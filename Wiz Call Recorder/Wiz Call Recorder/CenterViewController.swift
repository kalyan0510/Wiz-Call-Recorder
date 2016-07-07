//
//  CenterViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 6/29/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func collapseSidePanel()
}
extension CenterViewController: SidePanelViewControllerDelegate {
    
    
    func Selected(num: Int) {
        
        //var centerNavigationController: UINavigationController!
        self.view.willRemoveSubview(UINavigationController(rootViewController: currentViewController).view)
        print("called \(num)")
        switch num {
        case 1:
            currentVc = .Recordings
            currentViewController = UIStoryboard.recordingsViewController()
            break
        case 2:
            currentVc = .Settings
            currentViewController = UIStoryboard.settingsViewController()
            break
        case 3:
            currentVc = .VoiceRecord
            currentViewController = UIStoryboard.voiceRecordViewController()
            break
        case 4:
            currentVc = .Cloud
            currentViewController = UIStoryboard.cloudViewController()
            break
        case 5:
            //currentVc = .ShareApp
            //currentViewController = UIStoryboard.shareAppViewController()
            self.parentViewController?.view.makeToast(message: "Need to put code for sharing the app", duration: 1.0 , position: HRToastPositionTop)
            break
        case 6:
            currentVc = .AboutApp
            currentViewController = UIStoryboard.aboutAppViewController()
            break
        default:
            currentVc = .Recordings
            currentViewController = UIStoryboard.recordingsViewController()
        }
        updatevc(num)
    }
}
enum vcs {
    case Recordings
    case Settings
    case VoiceRecord
    case Cloud
    case ShareApp
    case AboutApp
}
class CenterViewController: UIViewController {

    
    var delegate: CenterViewControllerDelegate?
    //var centerNavigationController: UINavigationController!
    var settingsViewController : UIViewController!
    var currentVc : vcs = .Recordings
    var currentViewController : UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentViewController = UIStoryboard.recordingsViewController()
        updatevc(1)
       
        //settingsViewController = UIStoryboard.settingsViewController()
        
        /*centerNavigationController = UINavigationController(rootViewController: settingsViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMoveToParentViewController(self)*/
        // Do any additional setup after loading the view.
    }
    
    func updatevc(num : Int){
        
        //centerNavigationController = UINavigationController(rootViewController: currentViewController)
        
        for viewx in self.view.subviews{
            viewx.removeFromSuperview()
        }
        
        view.addSubview(currentViewController.view)
        addChildViewController(currentViewController)
        currentViewController.didMoveToParentViewController(self)
        delegate?.collapseSidePanel?()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slidetapped(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
