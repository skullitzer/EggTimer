//
//  ViewController.swift
//  EggTimer
//
//  Created by english on 2024-02-28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var audioPlayer: AVAudioPlayer?
    let eggTime = ["Soft": 3, "Medium": 4, "Hard": 7]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup if needed
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                self.progressBar.progress = Float(self.secondsPassed) / Float(self.totalTime)
            } else {
                self.titleLabel.text = "Done!"
                self.playAudio()
                Timer.invalidate()
            }
        }
    }
    
    func playAudio() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "wav") else {
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}

