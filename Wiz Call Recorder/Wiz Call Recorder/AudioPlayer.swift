//
//  AudioPlayer.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 7/2/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayer: AVAudioPlayer {
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    
    override init() {
        super.init()
    }
    
    func initPlayer(url: NSURL) {
        do{
            try self.audioPlayer = AVAudioPlayer(contentsOfURL: url)
        }catch{
            
        }
        
    }
    
    func playAudio(){
        self.audioPlayer.play()
    }
    
    func pauseAudio(){
        self.audioPlayer.pause()
    }
    
    class func timeFormat(val : Float) -> String{
        let minutes = (lroundf(val)/60)
        let seconds = lroundf(val) - (minutes*60)
        var x = "\(seconds)"
        if(seconds<10){
        x = "0\(seconds)"}
        
        
        
        return "\((minutes)):\((x))"
        
    }
    
    func setCurrentAudioTime(val : Float){
        self.audioPlayer.currentTime = NSTimeInterval(val)
    }
    
    func getCurrentAudioTime() -> NSTimeInterval{
        return  self.audioPlayer.currentTime
    }
    
    func getAudioDuratio() -> Double{
        return self.audioPlayer.duration
    }
    
}
