//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Lars Smit on 01/02/16.
//  Copyright © 2016 Lars Smit. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tapToRecordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingLabel.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden       = true
        tapToRecordLabel.hidden = false
        recordButton.enabled    = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden       = false
        recordButton.enabled    = false
        tapToRecordLabel.hidden = true
        recordingLabel.hidden   = false
        
        let dirPath       = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "my_audio.wav"
        let pathArray     = [dirPath, recordingName]
        let filePath      = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        // Use the speaker instead of the earbud speaker
        try! session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
 
        
        try! audioRecorder            = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate        = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl:recorder.url)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Recording was not succesful")
            recordButton.enabled = true
            stopButton.hidden    = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data                   = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopButton(sender: UIButton) {
        recordingLabel.hidden = true
        stopButton.hidden     = true
        recordButton.enabled  = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}

