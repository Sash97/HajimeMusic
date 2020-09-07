//
//  ContainerSceneBuilder.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/12/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit


protocol ContainerSceneBuilding {
    static func createContainerScene(coordinator: ContainerCoordinator) -> UIViewController
    static func createMenuScene() -> UIViewController
    static func createHomeScene(coordinator: HomeCoordinator) -> UIViewController
    static func createPlayerScene(coordinator: HomeCoordinator, artist: Artist) -> UIViewController
}

class ContainerSceneBuilder: ContainerSceneBuilding {
    static func createContainerScene(coordinator: ContainerCoordinator) -> UIViewController {
        let containerController = UIStoryboard.main.instantiateViewController(withIdentifier: Controller.container) as! ContainerController
        containerController.coordinator = coordinator
        containerController.modalPresentationStyle = .fullScreen
        return containerController
    }
    
    static func createMenuScene() -> UIViewController {
        let menuController = UIStoryboard.main.instantiateViewController(identifier: Controller.menu)
        return menuController
    }
    
    static func createHomeScene(coordinator: HomeCoordinator) -> UIViewController {
        let homeController = UIStoryboard.main.instantiateViewController(identifier: Controller.home) { (coder) in
            HomeController(coder: coder, coordinator: coordinator)
        }
        return homeController
    }
    
    static func createPlayerScene(coordinator: HomeCoordinator, artist: Artist) -> UIViewController {
        let playerController = UIStoryboard.main.instantiateViewController(identifier: Controller.player) { (coder) in
            PlayerController(coder: coder, coordinator: coordinator, audioPlayer: ABAudioPlayer(artist: artist))
        }
        return playerController
    }
}
