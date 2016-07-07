//
//  FunnyViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 7/3/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit
import QuartzCore

class FunnyViewController: UIViewController {

    var url : NSURL = NSURL()
    var name = ""
    
    @IBOutlet weak var uieffect: UIVisualEffectView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        uieffect.effect = UIBlurEffect(style: .Light)
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        uieffect.layer.cornerRadius = 5
        uieffect.layer.masksToBounds = true
        let   currentViewController = UIStoryboard.audioVideoPlayerViewController()! as! AudioVideoPlayerViewController
        currentViewController.setURL(url, name: name)
        view.addSubview(currentViewController.view)
        addChildViewController(currentViewController)
        currentViewController.didMoveToParentViewController(self)
        // Do any additional setup after loading the view.
    }
    
    func setmyUrl(url: NSURL, nam: String){
        self.url = url
        name = nam
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
