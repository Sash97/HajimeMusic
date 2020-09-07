//
//  MainCoordinator.swift
//  Evenation
//
//  Created by Aleksandr Bagdasaryan on 12/14/19.
//  Copyright © 2019 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    init(navigationController: UINavigationController?)
    
    func start()
}

protocol Rooting {
    func root() -> UIViewController
}

class MainCoordinator: BaseCoordinator, Rooting {
    
    //MARK: - Methods -
    
    func root() -> UIViewController {
        return self.childContainer()
    }
    
    func childContainer() -> UIViewController {
        let child = ContainerCoordinator(navigationController: self.navigationController)
        child.parentCoordinator = self
        self.childCoordinators.append(child)
        return child.root()
    }
 
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in self.childCoordinators.enumerated() {
            if coordinator === child {
                self.childCoordinators.remove(at: index)
                break
            }
        }
    }
}













