//
//  Artist.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/19/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit


struct Artist {
    let image: UIImage
    let name: String
    let audios: [Audio]?
    var currentAudioIndex: Int?
}

extension Artist {
    static func starterArtists() -> [Artist] {
        var artists   = [Artist]()
        let miyagi    = Artist(image: #imageLiteral(resourceName: "miyagi-removebg-preview"), name: "Miyagi", audios: Audio.miyagiMusic())
        let andyPanda = Artist(image: #imageLiteral(resourceName: "andy"), name: "Andy Panda", audios: Audio.andyMusic())
        let tumaniyo  = Artist(image: #imageLiteral(resourceName: "tumaniyo"), name: "Tumaniyo", audios: Audio.tumaniyoMusic())
        let kadi      = Artist(image: #imageLiteral(resourceName: "kadi"), name: "KADI", audios: Audio.kadiMusic())
        let hloy      = Artist(image: #imageLiteral(resourceName: "hloy"), name: "HLOY", audios: Audio.hloyMusic())
        let ollane    = Artist(image: #imageLiteral(resourceName: "ollane"), name: "Ollane", audios: Audio.ollaneMusic())
        let castle    = Artist(image: #imageLiteral(resourceName: "Castle"), name: "Castle", audios: Audio.castleMusic())
        artists.append(miyagi)
        artists.append(andyPanda)
        artists.append(tumaniyo)
        artists.append(kadi)
        artists.append(hloy)
        artists.append(ollane)
        artists.append(castle)
        return artists
    }
}



