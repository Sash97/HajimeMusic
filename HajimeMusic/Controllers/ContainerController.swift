//
//  ContainerController.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/12/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit


class ContainerController: UIViewController {
    //MARK: - Properties -
    
    private let homeCoordinator = HomeCoordinator(navigationController: ABNavigationController())
    private var menuBarController: UIViewController!
    private var menuIsShown = false

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    
    
    //MARK: - Dependencies -
    
    weak var coordinator: ContainerCoordinator?
    

    
    //MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSideBarNotification()
        self.configureHomeController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
  
    
    //MARK: - Methods -
    
    private func configureHomeController() {
        self.homeCoordinator.start()
        self.addChild(self.homeCoordinator.navigationController!)
        self.view.addSubview(self.homeCoordinator.navigationController!.view)
        self.homeCoordinator.navigationController!.didMove(toParent: self)
    }
    
    private func configureMenuBarController() {
        if self.menuBarController == nil {
            self.menuBarController = ContainerSceneBuilder.createMenuScene()
            self.addChild(self.menuBarController)
            self.view.insertSubview(self.menuBarController.view, at: 0)
            self.menuBarController.didMove(toParent: self)
        }
    }
    
    private func configureSideBarNotification() {
        self.observeNotification(name: .sideBarButtonTapped, selector: #selector(configureSideBarNotificationHelper))
    }
    
    @objc private func configureSideBarNotificationHelper() {
        self.sideBarButtonTapped()
    }
    
    private func sideBarButtonTapped(completion: (() -> ())? = nil) {
        self.configureMenuBarController()
        self.menuIsShown.toggle()
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.95,
                       initialSpringVelocity: 0.95,
                       options: .curveEaseOut,
                       animations: {
                        self.homeCoordinator.navigationController!.view.layer.cornerRadius = self.menuIsShown ? 25 : 0
                        self.homeCoordinator.navigationController!.view.layer.masksToBounds = self.menuIsShown ? true : false
                        self.homeCoordinator.navigationController!.view.transform = self.getTransform(where: self.menuIsShown)
        })
    }

    private func getTransform(where menuIsShown: Bool) -> CGAffineTransform {
        var transform = CGAffineTransform.identity
        transform = menuIsShown ? transform.scaledBy(x: 0.9, y: 0.9) : transform.scaledBy(x: 1, y: 1)
        transform = menuIsShown ? transform.rotated(by: -19) : transform.rotated(by: 0)
        transform = menuIsShown ? transform.translatedBy(x: 220, y: 40) : transform.translatedBy(x: 0, y: 0)
        return transform
    }
}



