//
//  MainCoordinator.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 15.05.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var children: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HeroListViewController.getInstance()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentDetail() {
        let viewController = HeroDetailViewController.getInstance()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismissDetail() {
        navigationController.popToRootViewController(animated: true)
    }
    
}
