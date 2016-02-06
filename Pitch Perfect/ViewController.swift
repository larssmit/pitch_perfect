//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Lars Smit on 01/02/16.
//  Copyright © 2016 Lars Smit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingLabel.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false
        recordButton.enabled = false
        if recordingLabel.hidden == true {
            recordingLabel.hidden = false
        } else {
            recordingLabel.hidden = true
        }
    }
    
    @IBAction func stopButton(sender: UIButton) {
        recordingLabel.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
    }
    
}

