//
//  AristsCell.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/19/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



class ArtistsCell: UITableViewCell {
    //MARK: - Outlets -
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backgroundArtistImageView: UIImageView!
    
    @IBOutlet weak var artistImageView: UIImageView!
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var moreAboutButton: UIButton!
    
    @IBOutlet weak var playlistView: PlaylistView!
    @IBOutlet weak var playlistViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var playlistViewProportionConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var backViewProportionConstraint: NSLayoutConstraint!
    
    
    //MARK: - Properties -
    
    private var initialFrame: CGRect?
    private var initialCornerRadius: CGFloat?
    var tapGestureCallBack: (()->())?
    var artistCellMusicCellDidTapped: ((Int)->())?

    
    
    //MARK: - PlaylistView/Animation
    private var dragged = true {
        didSet {
            self.playlistViewProportionConstraint.isActive = dragged
            self.backViewProportionConstraint.isActive     = dragged
        }
    }
    private lazy var initialY: CGFloat = (self.playlistView.frame.origin.y - 40)
    private var backViewBotttomConstraint: NSLayoutConstraint!
    private var playlistViewBotttomConstraint: NSLayoutConstraint!
    
    
    
    //MARK: - Init -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
        self.dragTopView()
        self.setupTapGesture()
        self.musicCellDidTapped()
    }
    
    
    //MARK: - Methods -
    
    private func musicCellDidTapped() {
        self.playlistView.musicCellDidTapped =  { [weak self] index in
            guard let self = self else { return }
            self.artistCellMusicCellDidTapped?(index!)
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(topViewPanGesture))
        self.backView.isUserInteractionEnabled = false
        self.backView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func topViewPanGesture(gesture: UIPanGestureRecognizer) {
        self.tapGestureCallBack?()
    }
    
    private func configureCell() {
        self.backView.backgroundColor = .clear
        self.playlistView.alpha = 0
        self.configureMoreAboutButton()
    }
    
    private func configureMoreAboutButton() {
        self.moreAboutButton.layer.borderColor  = UIColor.white.cgColor
        self.moreAboutButton.layer.borderWidth  = 2
        self.moreAboutButton.layer.cornerRadius = 16
    }
    
    func setCell(with model: Artist?) {
        guard let model = model else { return }
        self.artistImageView.image = model.image
        self.artistName.text       = model.name
        self.playlistView.artist   = model
    }
    
    
    //MARK: - Actions -
    
    private func dragTopView() {
        self.playlistView.dragTopView = { [weak self] y, chevronImageView in
            guard let self = self else { return }
            
            self.playlistView.tableView.isScrollEnabled = true
            
            if self.playlistView.frame.origin.y < self.playlistView.frame.height / 3 * 1.8 && y < 0  {
                return
            }
            
            if self.initialY <= self.playlistView.frame.origin.y && y >= 0 {
                UIView.customAnimate(animations: { chevronImageView.transform = .identity })
                self.playlistView.tableView.isScrollEnabled = false
                self.playlistView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                return
            }
            
            UIView.customAnimate(animations: {
                if self.dragged {
                    self.dragged = false
                    self.backViewProportionConstraint =   self.backView.bottomAnchor.constraint(equalTo: self.playlistView.bottomAnchor, constant: -200)
                    self.backViewProportionConstraint.isActive = true
                    self.playlistViewBotttomConstraint =  self.playlistView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
                    self.playlistViewBotttomConstraint.isActive = true
                }
                
                
                self.backViewProportionConstraint.constant -= y < 0 ? 26 : -26
                chevronImageView.transform =  CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                self.layoutIfNeeded()
            })
        }
    }
}




// MARK: - Showing/Hiding Logic
extension ArtistsCell: Expandable {
    func hide(in tableView: UITableView, frameOfSelectedCell: CGRect) {
        self.initialFrame = self.frame
        
        let currentY = self.frame.origin.y
        let newY: CGFloat
        
        if currentY < frameOfSelectedCell.origin.y {
            let offset = frameOfSelectedCell.origin.y - currentY
            newY = tableView.contentOffset.y - offset - 300
        } else {
            let offset = currentY - frameOfSelectedCell.maxY
            newY = tableView.contentOffset.y + tableView.frame.height + offset + 400
        }
        
        self.frame.origin.y = newY
        self.alpha = 0
        
        self.layoutIfNeeded()
    }
    
    func show() {
        self.frame = initialFrame ?? self.frame
        self.initialFrame = nil
        self.alpha = 1
        self.layoutIfNeeded()
    }
    
    // MARK: - Expanding/Collapsing Logic
    
    func expand(in tableView: UITableView, last: Bool = false) {
        self.initialFrame = self.frame
        self.initialCornerRadius = self.contentView.layer.cornerRadius
        self.contentView.layer.cornerRadius = 0
        
        var y = tableView.contentSize.height - tableView.frame.height - 100
        if tableView.contentOffset.y < y { y = tableView.contentOffset.y }
        self.frame = CGRect(x: 0, y: last ? y : tableView.contentOffset.y,
                            width: tableView.frame.width, height: tableView.frame.height + 100)
        
        self.moreAboutButton.alpha = 0
        self.playlistView.alpha = 1
        self.backView.isUserInteractionEnabled = true
        
        self.layoutIfNeeded()
    }
    
    func collapse() {
        
        self.contentView.layer.cornerRadius = self.initialCornerRadius ?? self.contentView.layer.cornerRadius
        
        self.frame = self.initialFrame ?? self.frame
        
        if !self.dragged {
            self.backViewProportionConstraint = self.backView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7)
            self.playlistViewProportionConstraint = self.playlistView.heightAnchor.constraint(equalTo: self.backView.heightAnchor, multiplier: 0.285714)
            
            self.playlistViewBotttomConstraint.isActive = false
            self.dragged = true
        }
        
        
        self.initialFrame = nil
        self.initialCornerRadius = nil
        
        self.moreAboutButton.alpha = 1
        self.playlistView.alpha = 0
        self.backView.isUserInteractionEnabled = false
        
        self.layoutIfNeeded()
    }
}
