//
//  SidePanelViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 6/29/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    func Selected(num : Int)
}


class SidePanelViewController: UITableViewController {

    @IBOutlet weak var headcell: UITableViewCell!
    @IBOutlet weak var imagehead: UIImageView!
     var delegate: SidePanelViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIScreen.mainScreen().bounds.width)
        
        
    }

    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : MyCell = tableView.dequeueReusableCellWithIdentifier("headimage", forIndexPath: indexPath) as! MyCell
        cell.imageView?.image = UIImage(named: "logo_for_notification")
        return cell
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.item)
        delegate?.Selected(indexPath.item)
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
