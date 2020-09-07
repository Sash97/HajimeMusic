//
//  PlaylistView.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/21/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit

class PlaylistView: UIView {

    //MARK: - Outlets -
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var chevronImageView: UIImageView!
    
    
    
    //MARK: - Properties -
    
    var artist: Artist? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var dragTopView: ((CGFloat, UIImageView)->())?
    var musicCellDidTapped: ((Int?)->())?
    
    lazy var frameHeight: CGFloat = self.frame.height
    
    
    
    //MARK: - Init -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.alwaysBounceVertical = false
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureSubviews()
    }
    
    
    //MARK: - Methods -
    
    private func configureSubviews() {
        self.setupView()
        self.configureViewStyle()
        self.configureTopView()
        self.configureTableView()
    }
    
    private func configureViewStyle() {
        self.layer.cornerRadius  = 16
        self.layer.masksToBounds = true
        let firstColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        let secondColor =  #colorLiteral(red: 0.1215686275, green: 0.01176470588, blue: 0.4235294118, alpha: 1)
        self.backView.setGradientColor(firstColor, secondColor, frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 700))
    }
    
    private func configureTableView() {
        self.addSubview(self.tableView)
        self.tableView.fillSuperview(padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        self.tableView.register(UINib(nibName: Nib.musicViewCell, bundle: nil), forCellReuseIdentifier: "MusicViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.alwaysBounceVertical = true
        self.tableView.indicatorStyle = .white
        self.tableView.backgroundColor = #colorLiteral(red: 0.3099315068, green: 0.09567636986, blue: 0.7351241438, alpha: 1)
        self.tableView.isScrollEnabled = false
    }
    
    private func configureTopView() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(topViewPanGesture))
        self.topView.isUserInteractionEnabled = true
        self.topView.addGestureRecognizer(panGesture)
    }
    
    @objc private func topViewPanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        self.dragTopView?(translation.y, self.chevronImageView)
    }
    
    private func setupView() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: Nib.playlistView, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    
    
    //MARK: - Actions -
    
    
}




extension PlaylistView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 0.6) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.musicCellDidTapped?(indexPath.row)
    }
}

extension PlaylistView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artist?.audios?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicViewCell", for: indexPath) as! MusicView
        cell.setCell(with: self.artist, index: indexPath.row)
        return cell
    }
    
    
}
