//
//  ContainerViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 6/29/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

//
//  ContainerViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import QuartzCore
enum SlideOutState {
    case LeftPanelExpanded
    case Collapsed
}
class ContainerViewController: UIViewController {
    
    //var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    var leftViewController: SidePanelViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    var currentState: SlideOutState = .Collapsed {
        didSet {
            let shouldShowShadow = currentState != .Collapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var rightViewController: SidePanelViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        //centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerViewController.view)
        addChildViewController(centerViewController)
        
        centerViewController.didMoveToParentViewController(self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handlePanGesture(_:)))
        centerViewController.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
}
extension ContainerViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel( notAlreadyExpanded)
    }
   
    
    func collapseSidePanel() {
        switch (currentState) {
        case .LeftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = UIStoryboard.leftViewController()
            
            
            addChildSidePanelController(leftViewController!)
        }
    }
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        sidePanelController.delegate = centerViewController
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    
    func animateLeftPanel(shouldExpand: Bool) {
        if (leftViewController == nil) {
            leftViewController = UIStoryboard.leftViewController()
            //leftViewController!.animals = Animal.allCats()
            addChildSidePanelController(leftViewController!)
        }
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(CGRectGetWidth(centerViewController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(0) { finished in
                self.currentState = .Collapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerViewController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerViewController.view.layer.shadowOpacity = 0.8
        } else {
            centerViewController.view.layer.shadowOpacity = 0.0
        }
    }
}
extension ContainerViewController: UIGestureRecognizerDelegate {
    // MARK: Gesture recognizer
    func float_mod(t: CGFloat,x: CGFloat) -> CGFloat{
        if(currentState == .LeftPanelExpanded) {
            return x
        }
        if(x<0 ){
            return 0
        }
        return x
    }
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
        case .Began:
            if (currentState == .Collapsed) {
                if (gestureIsDraggingFromLeftToRight) {
                    addLeftPanelViewController()
                }
                showShadowForCenterViewController(true)
            }
        case .Changed:
            recognizer.view!.center.x = recognizer.view!.center.x +
                float_mod(recognizer.view!.center.x,x: recognizer.translationInView(view).x)
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended:
            if (leftViewController != nil) {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateLeftPanel(hasMovedGreaterThanHalfway)
            } /*else if (rightViewController != nil) {
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x < 0
                animateRightPanel(hasMovedGreaterThanHalfway)
            }*/
        default:
            break
        }
    }
    
}
 extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LeftViewController") as? SidePanelViewController
    }
    
    class func centerViewController() -> CenterViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("CenterViewController") as? CenterViewController
    }
    
    class func settingsViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("SettingsViewController")
    }
    
    class func recordingsViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("RecordingsViewController")
    }
    
    class func voiceRecordViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("VoiceRecordViewController")
    }
    
    class func cloudViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("CloudViewController")
    }
    
    class func shareAppViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("ShareAppViewController")
    }
    
    class func aboutAppViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("AboutAppViewController")
    }
    
    class func audioVideoPlayerViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("AudioVideoPlayerViewController")
    }
    
    class func funnyViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("FunnyViewController")
    }
    
    class func callRecorderConfigViewController() -> UIViewController?{
        return mainStoryboard().instantiateViewControllerWithIdentifier("CallRecorderConfigViewController")
    }
    
}