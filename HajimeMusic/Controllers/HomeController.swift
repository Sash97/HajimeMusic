//
//  HomeController.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/12/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



class HomeController: UIViewController {
    
    //MARK - Outlets -
    
    @IBOutlet weak var artistTableView: UITableView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var abNavBarView: ABNavBarView!
    
    
    
    //MARK: - Properties -
    
    var artists: [Artist]? {
        didSet {
            self.artistTableView.reloadData()
        }
    }
    
    var hiddenCells: [ArtistsCell] = []
    var expandedCell: ArtistsCell?
    
    
    
    //MARK: - Dependencies -

    weak var coordinator: HomeCoordinator?



    //MARK: - Init -

    init?(coder: NSCoder, coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showMenu()
        self.configureTableView()
        self.configureViewStyle()
        self.configureNavigationBar()
        self.configureABNavBarView()
        self.configureModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    
    
    //MARK: - Methods -
    
    private func configureModel() {
        self.artists = Artist.starterArtists()
    }
    
    private func configureTableView() {
        self.artistTableView.delegate   = self
        self.artistTableView.dataSource = self
        self.artistTableView.tableHeaderView = UIView()
        self.artistTableView.tableFooterView = UIView()
    }
    
    private func configureABNavBarView() {
        self.abNavBarView.titleLabel.text = "Artists"
        self.abNavBarView.showHideView.isHidden = true
        self.abNavBarView.leftButton.setImage(UIImage(systemName: SFSymbols.listBullet), for: .normal)
    }
    
    private func configureViewStyle() {
        let firstColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        let secondColor =  #colorLiteral(red: 0.2803135702, green: 0.04366438356, blue: 0.6485177654, alpha: 1)
        self.view.setGradientColor(firstColor, secondColor, frame: self.view.bounds)
        self.backView.alpha = 0
    }
    
    private func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }

    private var showMenuIsHidden: Bool = true
    private func showMenu() {
        self.abNavBarView.leftButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.postNotification(name: .sideBarButtonTapped)
            self.showMenuIsHidden.toggle()
            UIView.animate(withDuration: 0.4) {
                self.abNavBarView.leftButton.transform = self.showMenuIsHidden ? .identity : CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0 / 2)
            }
        }
    }
}






