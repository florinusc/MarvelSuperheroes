//
//  MainCoordinator.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 15.05.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    
    private let repository = MockRepository()
    
    var children: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HeroListViewController.getInstance(with: HeroListViewModel(repository: repository))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentDetail(with viewModel: HeroDetailViewModel) {
        let viewController = HeroDetailViewController.getInstance(with: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismissDetail() {
        navigationController.popToRootViewController(animated: true)
    }
    
}
