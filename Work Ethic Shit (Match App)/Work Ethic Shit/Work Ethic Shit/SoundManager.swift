//
//  SoundManager.swift
//  Work Ethic Shit
//
//  Created by MBP on 04/04/2019.
//  Copyright © 2019 MBP. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        
        case flip
        
        case shuffle
        
        case match
        
        case nomatch
        // case noMatch ?
    }
    
    static func playSound(_ effect:SoundEffect) {
        
        var soundFilename = ""
        
        // Determine which sound effect we want to play
        // And set appropriate filename
        switch effect {
            
        case .flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
        
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
            
        //default:
        //    soundFilename = ""
            
        }
        
        // Get the path to sound path inside the bundle
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Couldn't find sound file \(soundFilename) in the bundle")
            return
            
        }
        
        // Create URL object from string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do {
        
            // Create audio player object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        
            // Play the sound
            audioPlayer?.play()
            
        }
        catch {
            // Couldn't catch audio player object, log the error
            print("Coulnd't create audio player object for sound file \(soundFilename)")
        }
        
            
    }
    
}
