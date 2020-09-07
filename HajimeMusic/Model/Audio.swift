//
//  Audio.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/27/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit


enum AudioFormat: String {
    case mp3 = "mp3"
}

protocol AudioCreator {
    static func miyagiMusic() -> [Audio]
    static func andyMusic() -> [Audio]
    static func tumaniyoMusic() -> [Audio]
    static func kadiMusic() -> [Audio]
    static func hloyMusic() -> [Audio]
    static func castleMusic() -> [Audio]
    static func ollaneMusic() -> [Audio]
}


struct Audio {
    let fullName: String?
    let format: AudioFormat?
    let labelImage: UIImage?
    let artistName: String?
    let songName: String?
    //var url: String? = nil
}


extension Audio: AudioCreator {
    static func tumaniyoMusic() -> [Audio] {
       var audios = [Audio]()
       let rainyDay = Audio(fullName: "TumaniYO - Rainy Day (feat. Hloy)", format: .mp3, labelImage: #imageLiteral(resourceName: "rainyDay"), artistName: "TumaniYO", songName: "Rainy Day")
       audios.append(rainyDay)
       return audios
    }
    
    static func kadiMusic() -> [Audio] {
        var audios = [Audio]()
        let astral = Audio(fullName: "Kadi - Aстрал", format: .mp3, labelImage: #imageLiteral(resourceName: "astral"), artistName: "KADI", songName: "Astral")
        audios.append(astral)
        return audios
    }
    
    static func hloyMusic() -> [Audio] {
        var audios = [Audio]()
        let rainyDay = Audio(fullName: "TumaniYO - Rainy Day (feat. Hloy)", format: .mp3, labelImage: #imageLiteral(resourceName: "rainyDay"), artistName: "Hloy", songName: "Rainy Day")
        audios.append(rainyDay)
        return audios
    }
    
    static func castleMusic() -> [Audio] {
        var audios = [Audio]()
        let feel = Audio(fullName: "Andy Panda, Castle - I Wanna Feel The Love", format: .mp3, labelImage: #imageLiteral(resourceName: "castleMusic"), artistName: "Castle", songName: "I Wanna Feel The Love")
        audios.append(feel)
        return audios
    }
    
    static func ollaneMusic() -> [Audio] {
        var audios = [Audio]()
        let lala = Audio(fullName: "Ollane - Lala", format: .mp3, labelImage: #imageLiteral(resourceName: "lala"), artistName: "Ollane", songName: "Lala")
        audios.append(lala)
        return audios
    }
    
    static func miyagiMusic() -> [Audio] {
        var audios = [Audio]()
        let samurai = Audio(fullName: "MiyaGi - Самурай", format: .mp3, labelImage: #imageLiteral(resourceName: "samurai"), artistName: "Miyagi", songName: "Samurai")
        let bismark = Audio(fullName: "Miyagi - Bismark", format: .mp3, labelImage: #imageLiteral(resourceName: "bismark"), artistName: "Miyagi", songName: "Bismark")
        let captain = Audio(fullName: "Miyagi - Captain", format: .mp3, labelImage: #imageLiteral(resourceName: "captain"), artistName: "Miyagi", songName: "Captain")
        let sorry   = Audio(fullName: "Miyagi - Sorry", format: .mp3, labelImage: #imageLiteral(resourceName: "sorry"), artistName: "Miyagi", songName: "Sorry")
        let medecine = Audio(fullName: "MiyaGi & Andy Panda - Medicine", format: .mp3, labelImage: #imageLiteral(resourceName: "yamakasi"), artistName: "Miyagi", songName: "Medicine")
        let psixpatia = Audio(fullName: "Miyagi, Andy Panda - Психопатия", format: .mp3, labelImage: #imageLiteral(resourceName: "yamakasi"), artistName: "Miyagi", songName: "Психопатия")
        let neJal = Audio(fullName: "MiyaGi Скриптонит feat. 104 - Не Жаль", format: .mp3, labelImage: #imageLiteral(resourceName: "nejal"), artistName: "Miyagi", songName: "Не Жаль")
        audios.append(samurai)
        audios.append(bismark)
        audios.append(captain)
        audios.append(sorry)
        audios.append(medecine)
        audios.append(psixpatia)
        audios.append(neJal)
        return audios
    }
    
    static func andyMusic() -> [Audio] {
        var audios = [Audio]()
        let kosandra = Audio(fullName: "MiyaGi & Andy Panda - Kosandra", format: .mp3, labelImage: #imageLiteral(resourceName: "kosandra"), artistName: "MiyaGi & Andy Panda", songName: "Kosandra")
        let minor = Audio(fullName: "MiyaGi & Andy Panda - Minor", format: .mp3, labelImage: #imageLiteral(resourceName: "yamakasi"), artistName: "MiyaGi & Andy Panda", songName: "Minor")
        let utopia = Audio(fullName: "MiyaGi feat. Andy Panda - Utopia", format: .mp3, labelImage: #imageLiteral(resourceName: "utopia"), artistName: "MiyaGi feat. Andy Panda", songName: "Utopia")
        audios.append(kosandra)
        audios.append(minor)
        audios.append(utopia)
        return audios
    }
}



struct Music: Codable {
    let musicUrl: String?
}
