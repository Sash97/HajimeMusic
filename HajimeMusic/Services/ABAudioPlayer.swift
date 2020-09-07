//
//  ABAudioPlayer.swift
//  NeumorphicDesignMusicApp
//
//  Created by Aleksandr Bagdasaryan on 7/21/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import AVKit



enum PlayerError: String, Error {
    case absenseSound
}

protocol AudioPlayer {
    func play()
    func pause()
    func forward()
    func backward()
    func setupPlayer() throws
    func prepareToPlay()
    var audio: Audio? { get }
    var audioCurrentTime: TimeInterval! { get set }
    var audioDuration: TimeInterval! { get set }
}



class ABAudioPlayer: AudioPlayer {
    
    //MARK: - Properties -
    
    private var audioPlayer: AVAudioPlayer! {
        didSet {
            self.audioCurrentTime = audioPlayer.currentTime
            self.audioDuration = audioPlayer.duration
        }
    }
    var currentMusicIndex: Int = 0
    var artist: Artist
    var audio: Audio?
    var audioCurrentTime: TimeInterval! {
        get {
            return self.audioPlayer.currentTime
        }
        set {
            self.audioPlayer.currentTime = newValue
        }
    }
    var audioDuration: TimeInterval!
    
    
    
    
    //MARK: - Init -
    
    init(artist: Artist) {
        self.artist = artist
        self.currentMusicIndex = artist.currentAudioIndex ?? 0
    }
    
    
    
    //MARK: - Methods -
    
    func prepareToPlay() {
        self.audioPlayer.prepareToPlay()
    }
    
    func play() {
        //self.setCurrentAudio()
        self.audioPlayer.play()
        
    }
    
    func pause() {
        self.audioPlayer.pause()
    }
    
    func forward() {
        self.currentMusicIndex < artist.audios!.count - 1 ? (self.currentMusicIndex += 1) : (self.currentMusicIndex = 0)
        self.setCurrentAudio()
        
        do {
            try self.helperSetupPlayer(forResource: artist.audios![self.currentMusicIndex].fullName,
                                       ofType: artist.audios![self.currentMusicIndex].format?.rawValue)
            self.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func backward() {
        self.currentMusicIndex == 0 ? (self.currentMusicIndex = artist.audios!.count - 1 ) : (self.currentMusicIndex -= 1)
        self.setCurrentAudio()
        
        do {
            try self.helperSetupPlayer(forResource: artist.audios![self.currentMusicIndex].fullName,
                                       ofType: artist.audios![self.currentMusicIndex].format?.rawValue)
            self.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setupPlayer() throws {
        try self.helperSetupPlayer(forResource: artist.audios?[artist.currentAudioIndex ?? 0].fullName,
                                   ofType: artist.audios?[artist.currentAudioIndex ?? 0].format?.rawValue)
    }
    
    private func helperSetupPlayer(forResource: String?, ofType: String?) throws {
        guard let sound = Bundle.main.path(forResource: forResource, ofType: ofType) else { throw PlayerError.absenseSound }
        self.setCurrentAudio()
        self.audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
    }
    
    private func setCurrentAudio() {
        self.audio = artist.audios?[self.currentMusicIndex]
    }
}




