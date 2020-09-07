//
//  MusicView.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/23/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



class MusicView: UITableViewCell {
    //MARK: - Outlets -
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var labelImageView: UIImageView!
    @IBOutlet weak var aristNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    


    //MARK: - Init -
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureSubviews()
    }
    
    
    
    //MARK: - Methods -
    
    private func configureSubviews() {
        self.configureViewStyle()
    }
    
    private func configureViewStyle() {
        self.selectionStyle = .none
        self.separatorInset = .init(top: 0, left: 1000, bottom: 0, right: 0)
        self.backView.layer.cornerRadius = 16
        self.backView.setShadow(color: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1).cgColor, radius: 3, opacity: 1)
        self.labelImageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 16)
        self.playButton.layer.cornerRadius = 15
        self.playButton.setShadow(color: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1).cgColor, radius: 3, opacity: 1)
        self.backgroundColor = .clear
    }
    
    func setCell(with artist: Artist?, index: Int) {
        guard let artist = artist else { return }
        self.labelImageView.image = artist.audios?[index].labelImage
        self.aristNameLabel.text  = artist.name
        self.songNameLabel.text   = artist.audios?[index].songName
    }

    
    
    //MARK: - Actions -
    
    @IBAction func playButtonAction(_ sender: UIButton) {
    }
}
