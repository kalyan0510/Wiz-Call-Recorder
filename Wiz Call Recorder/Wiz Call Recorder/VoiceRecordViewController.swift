//
//  VoiceRecordViewController.swift
//  Wiz Call Recorder
//
//  Created by IIT Indore on 6/29/16.
//  Copyright © 2016 kalyan0510. All rights reserved.
//

import UIKit
import AVFoundation
import SpriteKit
import SceneKit

class VoiceRecordViewController: UIViewController , AVAudioRecorderDelegate {

    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var timer : NSTimer = NSTimer()
    
    @IBOutlet weak var scnView: SCNView!
   
    @IBOutlet weak var recButton: UIButton!
   
    @IBOutlet weak var vLabel: UILabel!
    
    var scene : EqualierScene = EqualierScene(fileNamed: "MyScene")!
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingSession = AVAudioSession.sharedInstance()
       // playPauseButton.setTitle("play \(getCurrentFileNameforSelfRecord())", forState: .Normal)
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                        self.vLabel.text = "Voice Record"
                    } else {
                        // failed to record!
                        self.vLabel.text = "Unable to get Permission"
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
       /* scene = EqualierScene(fileNamed: "MyScene")!
        if let scene1 = EqualierScene(fileNamed:"MyScene") {
            // Configure the view.
            let skView = scnView as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene1.scaleMode = .AspectFill
            skView.presentScene(scene1)
        }
        */
        sceneSetup()
        
    }
    func sceneSetup() {
        let scene = SCNScene()
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLightTypeOmni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        scene.rootNode.addChildNode(omniLightNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 25)
        scene.rootNode.addChildNode(cameraNode)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(VoiceRecordViewController.panGesture(_:)))
        scnView.addGestureRecognizer(panRecognizer)
        
        scnView.scene = scene
        geometryNode = Atoms.allAtoms()
        backbar = Atoms.bars()
        backbarN = Atoms.barsN()
        textNode = Atoms.textNode()
        //textNode.position = SCNVector3Make(0, 0, 0)
        var v1 = SCNVector3() , v2 = SCNVector3()
        textNode.getBoundingBoxMin(&v1, max: &v2)
        
        textNode.position = SCNVector3Make((v1.x-v2.x)/2,v1.y-v2.y,0)
        //print("V! \(SCNVector3Make((v1.x-v2.x)/2,v1.y-v2.y,0))")

        scnView.scene!.rootNode.addChildNode(geometryNode)
        scnView.scene!.rootNode.addChildNode(backbar)
        scnView.scene!.rootNode.addChildNode(backbarN)
        scnView.scene!.rootNode.addChildNode(textNode)
        geometryNode.childNodeWithName("carbon", recursively: false)?.transform = SCNMatrix4MakeRotation(Float(M_PI_2), 1, 0, 0)
        geometryNode.childNodeWithName("carbon", recursively: false)?.position = SCNVector3Make(0, 0, 0)
        
        //backbar1.childNodeWithName("bar", recursively: false)?.position = SCNVector3Make(-2, 0, 0)
        //backbar1.childNodeWithName("bar", recursively: false)?.pivot = SCNMatrix4MakeTranslation(0, -2.5, 0)
        var i=0
        for node in backbar.childNodes{
            Atoms.incHto(node,float: Float(40/8)*Float(Coeff[(i%18)]))
            i+=1
        }
        i=0
        for node in backbarN.childNodes{
            Atoms.incHtoN(node,float: Float(40/8)*Float(Coeff[(i%18)]))
            i+=1
        }
        //scnView.scene?.rootNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByAngle(CGFloat(M_PI), aroundAxis: SCNVector3(0,1,0), duration: 10)))
        partcSys = SCNParticleSystem(named: "MyParticleSystem", inDirectory: nil)!
      //  ps.emitterShape = Atoms.squareBoxEmitter()
        
        scnView.scene?.addParticleSystem(partcSys, withTransform: SCNMatrix4())
        
        
    }
    var currentAngle: Float = 0.0
    var geometryNode: SCNNode = SCNNode()
    var backbar : SCNNode = SCNNode()
    var backbarN : SCNNode = SCNNode()
    var textNode : SCNNode = SCNNode()
    var partcSys : SCNParticleSystem = SCNParticleSystem()
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view!)
        var newAngle = (Float)(translation.x)*(Float)(M_PI)/180.0
        newAngle += currentAngle
        
        geometryNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        backbar.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        backbarN.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        //textNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        if(sender.state == UIGestureRecognizerState.Ended) {
            currentAngle = newAngle
        }
    }
    var min=200.0 , max = 0.0;
    var Coeff = [0.14,0.20,0.34,0.23,0.12,0.2,0.04,0.1,0.13,0.21,0.10,0.07,0.13,0.2,0.6,0.8,0.3,0.2]
    var laspx = CGFloat(1.0),ddf = CGFloat(1.0);
    
    func update(){
        
            audioRecorder.updateMeters()
            // print("* \(audioRecorder.peakPowerForChannel(0)) -  \(audioRecorder.averagePowerForChannel(0))  -  \(audioRecorder.averagePowerForChannel(3))")
        
            // let node = geometryNode
            var px = CGFloat(audioRecorder.averagePowerForChannel(0)+60)
            // print("px  \(px)")
            if(px<0){
                px = 0
            }else if(px>80){
                px = 80
            }
            if(px==(-60)){
                print("RETD")
                return
           
            }
            //print(floor(px))
        
        
            var q = CGFloat();
            if(px<30){
                q = (px/30)*(2.85)
            }else if (px<45){
                q = 2.85 + ((px-30)/15)*(1.42)
            }else{
                q = 4.27 + ((px-45)/35)*(2.85)
            }
        
            let p = (  pow(CGFloat(M_E), (px/30)-0.666)/7   ) + 1//(px/80)+1
            if(p>0){
            let action = SCNAction.scaleBy(p/laspx, duration: 0.1)
            geometryNode.runAction(action)
        
                var i=0
                let a = [ Float((p-1)*13)  ,   abs(Float(p-laspx))*60   ]
                let b = [  Float(q) , a[0] , a[1] , sqrt(a[0]*a[1])]
                var ranStr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                for node in backbar.childNodes{
                    let y = random()%2
                    ranStr[i] = y
                    Atoms.incHto(node,float:b[y]*Float(Coeff[(i%18)]))    //b[random()%2]*Float(Coeff[(i%18)])
                    i+=1
                }
                i=0
                for node in backbarN.childNodes{
                    
                    Atoms.incHtoN(node,float:b[ranStr[i]]*Float(Coeff[(i%18)]))    //b[random()%2]*Float(Coeff[(i%18)])
                    i+=1
                }
            laspx = p
                
                if let txt = textNode.childNodes[0].geometry as? SCNText{
                    txt.string = AudioPlayer.timeFormat(Float(audioRecorder.currentTime))
                }else{
                    print("Pfffttttt...\(textNode.geometry)")
                }
                
            
          
            
            
        }
        
      /*  if audioRecorder.peakPowerForChannel(0) > 0 {
            let skv = scnView as SKView
            if let scn = skv.scene as? EqualierScene {
                scn.backgroundColor = UIColor(hue: 291, saturation: 21, brightness: 99, alpha: 1)
                scn.bulge(audioRecorder.peakPowerForChannel(0))
            }
        }
        */
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func recordVoice(sender: UIButton) {
        if audioRecorder == nil {
            sender.setTitle("Stop", forState:.Normal)
            sender.setImage(UIImage(named: "stopred"), forState: .Normal)
            startRecording()
        } else {
            sender.setImage(UIImage(named: "recordbutton"), forState: .Normal)
            sender.setTitle("recordbutton", forState:.Normal)
            finishRecording(success: true)
            scnView.scene!.rootNode.childNodes.forEach({ (node) in
                node.removeFromParentNode()
            })
            sceneSetup()
        }
    }
    
    func startRecording() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(VoiceRecordViewController.update), userInfo: nil, repeats: true)
        //vLabel.text = "stop"
        print("STARTED")

        let audioURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(getNewFileNameforSelfRecord())
        //let audioURL = NSURL(fileURLWithPath: audioFilename)
        print(audioURL)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 2 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            //recordButton.setTitle("Tap to Stop", forState: .Normal)
        } catch {
            finishRecording(success: false)
        }
        audioRecorder.meteringEnabled = true
    }
    
    
    
    func finishRecording(success success: Bool) {
        
        timer.invalidate()
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
           // vLabel.text = "Tap to Re-record"
        } else {
           // vLabel.text = "Tap to Record"
            // recording failed :(
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
            vLabel.text = "OS stopped"
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
        
    

    @IBAction func buttonPressed(sender: UIButton) {
        if let audioRecorderx = audioRecorder{
        if(audioRecorderx.recording){
                finishRecording(success: true)
                recButton.setImage(UIImage(named: "recordbutton"), forState: .Normal)
                recButton.setTitle("recordbutton", forState:.Normal)
            }
        }
        let currentViewController = UIStoryboard.funnyViewController()! as! FunnyViewController
        currentViewController.setmyUrl(NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(getCurrentFileNameforSelfRecord()),nam: getCurrentFileNameforSelfRecord())
        view.addSubview(currentViewController.view)
        addChildViewController(currentViewController)
        currentViewController.didMoveToParentViewController(self)
        
       
    }
    
}
