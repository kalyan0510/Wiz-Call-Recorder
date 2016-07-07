//
//  AudioVideoPlayerViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 7/2/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit
import AVFoundation

class AudioVideoPlayerViewController: UIViewController {

    
    var isPaused: Bool = true
    var scrubbing: Bool = false
    var timer: NSTimer = NSTimer()
    var audioPlayer: AudioPlayer = AudioPlayer()
    var url: NSURL = NSURL()
    var name = ""
    
    @IBOutlet weak var playPauseBut: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        self.audioPlayer.initPlayer(url)
        self.slider.maximumValue = Float(audioPlayer.getAudioDuratio())
        slider.setValue(0, animated: true)
        self.endLabel.text = AudioPlayer.timeFormat(Float(self.audioPlayer.getAudioDuratio()))
        self.startLabel.text = "0:00"
        nameLabel.text = name
        
        

    }
    
    func  setURL(url: NSURL,name : String) {
        self.url = url
        self.name = name
    }
    
    func update(){
        slider.setValue(Float(audioPlayer.getCurrentAudioTime()), animated: true)
        startLabel.text = AudioPlayer.timeFormat(Float(audioPlayer.getCurrentAudioTime()))
        endLabel.text = AudioPlayer.timeFormat(Float(audioPlayer.getAudioDuratio())-Float(audioPlayer.getCurrentAudioTime()))
        if(!self.audioPlayer.audioPlayer.playing){
            timer.invalidate()
            playPauseBut.setImage(UIImage(named: "play"), forState: .Normal)
            isPaused = true
           // print("SET")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playPauseButton(sender: UIButton) {
        timer.invalidate()
        if(isPaused){
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(AudioVideoPlayerViewController.update), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "pause"), forState: .Normal)
            self.audioPlayer.playAudio()
            isPaused = false
        }else{
            sender.setImage(UIImage(named: "play"), forState: .Normal)
            self.audioPlayer.pauseAudio()
            isPaused = true
        }
    }
    
  

    @IBAction func sliderScrubbing(sender: UISlider) {
        audioPlayer.setCurrentAudioTime(slider.value)
        startLabel.text = AudioPlayer.timeFormat(Float(audioPlayer.getCurrentAudioTime()))
        endLabel.text = AudioPlayer.timeFormat(Float(audioPlayer.getAudioDuratio())-Float(audioPlayer.getCurrentAudioTime()))
    }
    @IBAction func closeButtonPressed(sender: UIButton) {
        audioPlayer.audioPlayer.stop()
        let supv = self.view.superview
        self.view.removeFromSuperview()
        supv?.removeFromSuperview()
        
        
    }
    var haschangedPlaying: Bool = false
    @IBAction func touchDownSlider(sender: AnyObject) {
        
        if(!isPaused){
            haschangedPlaying = true
        }else{
            haschangedPlaying = false
        }
        
        audioPlayer.pauseAudio()
        isPaused = true
        playPauseBut.setImage(UIImage(named: "play"), forState: .Normal)
        timer.invalidate()
        
    }
    
    @IBAction func touchUPIslider(sender: AnyObject) {
    
        if(haschangedPlaying){
            audioPlayer.playAudio()
            isPaused = false
            playPauseBut.setImage(UIImage(named: "pause"), forState: .Normal)
        
        if slider.maximumValue == slider.value {
            audioPlayer.audioPlayer.stop()
            isPaused = true
            playPauseBut.setImage(UIImage(named: "play"), forState: .Normal)
        }
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(AudioVideoPlayerViewController.update), userInfo: nil, repeats: true)
    }
    
    @IBAction func touchUPOslider(sender: AnyObject) {
        if(haschangedPlaying){
            audioPlayer.playAudio()
            isPaused = false
            playPauseBut.setImage(UIImage(named: "pause"), forState: .Normal)
        
        if slider.maximumValue == slider.value {
            audioPlayer.audioPlayer.stop()
            isPaused = true
            playPauseBut.setImage(UIImage(named: "play"), forState: .Normal)
        }
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(AudioVideoPlayerViewController.update), userInfo: nil, repeats: true)
    }
    
    
}
