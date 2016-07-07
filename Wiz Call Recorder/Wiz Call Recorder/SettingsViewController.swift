//
//  SettingsViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 6/29/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit


class SettingsViewController: UITableViewController {

    
    @IBOutlet weak var CrcLabel: UILabel!
    
    @IBOutlet weak var AudioqLable: UILabel!
    
    @IBOutlet weak var AudiosLabel: UILabel!
    
    @IBOutlet weak var ThemeLabel: UILabel!
    
    var fromRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CrcLabel.text = crcEnumtoString(getCallRecorderConfig(true)) as String
        
        AudioqLable.text = aqInttoString(getAudioQuality())
        
        AudiosLabel.text = asInttoString(getAudioSource())
        
        ThemeLabel.text = themeInttoString(getTheme())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        fromRow = indexPath.item
        if(indexPath.item != 3){
           // self.performSegueWithIdentifier("popsegue", sender: indexPath.item)
            let currentViewController = UIStoryboard.callRecorderConfigViewController() as? CallRecorderConfigViewController
            currentViewController!.segueFromRow = fromRow
            self.view.addSubview(currentViewController!.view)
            addChildViewController(currentViewController!)
            currentViewController!.didMoveToParentViewController(self)
            
        }
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="popsegue"){
            let cvc = segue.destinationViewController as! CallRecorderConfigViewController
            cvc.segueFromRow = fromRow
        }
    }
    
    
    @IBAction func getfuckingSegue(segue:UIStoryboardSegue) {
        //print("fucking Seg-Way got")
        //print((segue.sourceViewController as! CallRecorderConfigViewController).pickeditem)
        let picdItem = (segue.sourceViewController as! CallRecorderConfigViewController).pickeditem
        
        switch fromRow {
        case 0:
            
            CrcLabel.text = crcEnumtoString( crcInttoEnum( picdItem) ) as String
            
            setCallRecorderConfig(crcInttoEnum(picdItem))
            
            break
        case 1:
            
            AudioqLable.text = aqInttoString(picdItem)
            
            setAudioQuality(picdItem)
            
            break
        case 2:
            
            AudiosLabel.text = asInttoString(picdItem)
            
            setAudioSource(picdItem)
            
            break
        case 4:
            
            ThemeLabel.text = themeInttoString(picdItem)
            
            setTheme(picdItem)
            
            break
            
        default:
            1
        }
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
