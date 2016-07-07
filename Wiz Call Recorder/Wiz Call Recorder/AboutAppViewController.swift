//
//  AboutAppViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 6/29/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit

class AboutAppViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.item {
        case 0:
            
            break
        case 1:
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.wizcallrecorder.com")!)
            break
        case 2:
            UIApplication.sharedApplication().openURL(NSURL(string: "mailto:info@wizcallrecorder.com")!)
            UIPasteboard.generalPasteboard().string = "info@wizcallrecorder.com"
            self.view.makeToast(message: "mail id copied to clipboard",duration: 1.2 , position: HRToastPositionTop)
            break
        case 3:
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.wizcallrecorder.com/privacy")!)
            break
            
        default:
            1
        }
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
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
