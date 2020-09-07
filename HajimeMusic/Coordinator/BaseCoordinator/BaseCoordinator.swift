//
//  BaseCoordinator.swift
//  Evenation
//
//  Created by Aleksandr Bagdasaryan on 12/14/19.
//  Copyright © 2019 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



class BaseCoordinator: NSObject, Coordinator {
    //MARK: - Properties -
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    
    
    //MARK: - Init -
    
    required init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    
    
    //MARK: - Methods -
    
    func start() {}
}
