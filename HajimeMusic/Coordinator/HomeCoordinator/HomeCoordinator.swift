//
//  HomeCoordinator.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/14/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



class HomeCoordinator: BaseCoordinator {
    
    //MARK: - Properties -
    
    weak var parentCoordinator: Coordinator?
    
    
    
    //MARK: - Methods -
    
    override func start() {
        let homeController = ContainerSceneBuilder.createHomeScene(coordinator: self)
        self.navigationController?.pushViewController(homeController, animated: true)
    }
    
    func drivePlayerController(from viewController: UIViewController,  artist: Artist) {
        let playerController = ContainerSceneBuilder.createPlayerScene(coordinator: self, artist: artist)
        viewController.present(playerController, animated: true)
    }
}
