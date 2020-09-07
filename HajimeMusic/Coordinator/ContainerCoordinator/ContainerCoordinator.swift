//
//  ContainerCoordinator.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/12/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



class ContainerCoordinator: BaseCoordinator, Rooting {
    
    //MARK: - Properties -
    
    weak var parentCoordinator: MainCoordinator?
    
    
    
    //MARK: - Methods -
    
    func root() -> UIViewController {
        let containerController = ContainerSceneBuilder.createContainerScene(coordinator: self)
        return containerController
    }
}
