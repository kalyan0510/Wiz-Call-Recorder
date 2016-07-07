//
//  Utilities.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 6/30/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit
enum callRecorderConfigEnum{
    case CRCAutomatic
    case CRCManual
    case CRCDisabled
}
class CallRecorderConfig{
    var config : callRecorderConfigEnum
    init(conf : callRecorderConfigEnum) {
        config = conf
    }
}
func setCallRecorderConfig(config : callRecorderConfigEnum){
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "crckey"
    preferences.setInteger(crcEnumtoInt(config), forKey: key)
    preferences.synchronize()
    
}
func getCallRecorderConfig(flag: Bool) -> callRecorderConfigEnum{
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "crckey"
    
    print("here -> \(preferences.objectForKey(key))")
    if preferences.valueForKey(key) == nil {
        
        
        if flag{
            return getCallRecorderConfig(false)
        }else{
            print("DUDE U R HEAVILY FUCKED UP YOO DUDE U R HEAVILY FUCKED UP YOO ")
            return .CRCAutomatic
        }
        
        
    }
    else {
        
        return crcInttoEnum( preferences.integerForKey(key))
    }
}
func crcEnumtoInt(config : callRecorderConfigEnum) -> Int{
    switch config {
    case .CRCAutomatic:
        return 0
    case .CRCManual:
        return 1
    case .CRCDisabled:
        return 2
    }
}
func crcInttoEnum(int : Int) -> callRecorderConfigEnum {
    switch int {
    case 0:
        return .CRCAutomatic
    case 1:
        return .CRCManual
    case 2:
        return .CRCDisabled
    default:
        return .CRCAutomatic
    }
}
func crcEnumtoString(config : callRecorderConfigEnum) -> NSString{
    switch config {
    case .CRCAutomatic:
        return "Automatic"
    case .CRCManual:
        return "Manual"
    case .CRCDisabled:
        return "Disabled"
    }
}

func setAudioQuality(item : Int){
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "adqkey"
    preferences.setInteger(item, forKey: key)
    preferences.synchronize()

}
func getAudioQuality() -> Int {
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "adqkey"
    if preferences.objectForKey(key) == nil {
         print("DUDE U R HEAVILY FUCKED UP ")
        return 0
    }
    else {
        return preferences.integerForKey(key)
    }
}
func aqInttoString(int : Int) -> String{
    let data = ["Low Quality ","Medium Quality","High Quality"]
    return data[int]
}

func setAudioSource(item : Int){
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "adskey"
    preferences.setInteger(item, forKey: key)
    preferences.synchronize()
    
}
func getAudioSource() -> Int {
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "adskey"
    if preferences.objectForKey(key) == nil {
         print("DUDE U R HEAVILY FUCKED UP ")
        return 0
    }
    else {
        return preferences.integerForKey(key)
    }
}
func asInttoString(int : Int) -> String{
    let data = ["Mic","Phone Line"]
    return data[int]
}


func setTheme(item : Int){
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "thmkey"
    preferences.setInteger(item, forKey: key)
    preferences.synchronize()
    
}
func getTheme() -> Int {
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "thmkey"
    if preferences.objectForKey(key) == nil {
        print("DUDE U R HEAVILY FUCKED UP ")
        return 0
    }
    else {
        return preferences.integerForKey(key)
    }
}
func themeInttoString(int : Int) -> String{
    let data = ["Orange","Cyan","Pink","Blue","Dark"]
    return data[int]
}

func setSelfRecordNo(item : Int){
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "selfRNkey"
    preferences.setInteger(item, forKey: key)
    preferences.synchronize()
    
}
func getSelfRecordNo() -> Int {
    let preferences  = NSUserDefaults.standardUserDefaults()
    let key = "selfRNkey"
    if preferences.objectForKey(key) == nil {
        print("DUDE U R TOTALLY FUCKED UP ")
        return 1
    }
    else {
        return preferences.integerForKey(key)
    }
}

func getNewFileNameforSelfRecord() -> String {
    var x = getSelfRecordNo()
    x+=1
    setSelfRecordNo(x)
    return "SelfRecord\(x).mp4"
}
func getCurrentFileNameforSelfRecord() -> String {
    let x = getSelfRecordNo()
    return "SelfRecord\(x).mp4"
}