//
//  ABNavController.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/14/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//



import UIKit



class ABNavigationController: UINavigationController {
    
    //MARK: - Properties -

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    
    
    //MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    
    
    //MARK: - Methods -

    fileprivate func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Times New Roman", size: 30)!]
        navBarAppearance.backgroundColor = .systemRed
        self.navigationBar.standardAppearance = navBarAppearance
        self.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
