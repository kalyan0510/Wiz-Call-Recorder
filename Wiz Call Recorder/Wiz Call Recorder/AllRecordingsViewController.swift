//
//  AllRecordingsViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 7/1/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit

class AllRecordingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycustomcell",forIndexPath: indexPath)
        
        if let userImage = cell.viewWithTag(1) as? UIImageView{
            userImage.layer.cornerRadius = userImage.bounds.width/2
            userImage.layer.masksToBounds = true
        }
        if let nameLabel = cell.viewWithTag(2) as? UILabel{
            nameLabel.text = "  Kalyan G"
        }
        if let timeLabel = cell.viewWithTag(5) as? UILabel{
            timeLabel.text = "  today, at 07:21 pm"
        }
        
        
        
        
        return cell
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
