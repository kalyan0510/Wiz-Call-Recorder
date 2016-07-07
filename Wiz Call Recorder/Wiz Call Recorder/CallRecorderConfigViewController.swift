//
//  CallRecorderConfigViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 6/30/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit
class CallRecorderConfigViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
    
   
    @IBOutlet weak var navitem: UINavigationItem!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var button: UIButton!
    var pickerData =
       [ ["Automatic","Manual","Disabled"],
    //var pickerData2 =
        ["Low Quality ","Medium Quality","High Quality"],
    //var pickerData3 =
        ["Mic","Phone Line"],[],
    //var pickerData4 =
        ["Orange","Cyan","Pink","Blue","Dark"] ]
    
    var opns = ["type","quality","source","","theme"]
    var segueFromRow : Int = 0
    var pickeditem : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.layer.cornerRadius = 5
        picker.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        view.backgroundColor = UIColor.clearColor()
        //view.opaque = false
        navitem.title = "select \(opns[segueFromRow])"
        
        picker.dataSource = self
        picker.delegate = self
        
        switch segueFromRow {
        case 0:
            pickeditem = crcEnumtoInt(getCallRecorderConfig(true))
            picker.selectRow(crcEnumtoInt(getCallRecorderConfig(true)), inComponent: 0, animated: true)
            break
        case 1:
            pickeditem = getAudioQuality()
            picker.selectRow(getAudioQuality(), inComponent: 0, animated: true)
            break
        case 2:
            pickeditem = getAudioSource()
            picker.selectRow(getAudioSource(), inComponent: 0, animated: true)
            break
        case 4:
            pickeditem = getTheme()
            picker.selectRow(getTheme(), inComponent: 0, animated: true)
        default:
            1
        }
        
        // Do any additional setup after loading the view.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch segueFromRow {
        case 0,1:
            return 3
        case 2:
            return 2
        case 4:
            return 5
        default:
            return 1
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[segueFromRow][row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("picked \(row)\n")
            pickeditem = row
    }

    @IBAction func unwindWithPickedConfig(segue:UIStoryboardSegue) {
        print("unwind\n")
    }
    

    @IBAction func done(sender: UIButton) {
        self.view.removeFromSuperview()
        self.performSegueWithIdentifier("fs", sender: pickeditem)
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
