//
//  HeroListViewController.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 14.05.2022.
//

import UIKit

class HeroListViewController: UIViewController, StoryboardViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        navigationController?.navigationBar.isHidden = true
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HeroTableViewCell.self)
        tableView.register(HeroCarouselTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }

}

extension HeroListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: HeroCarouselTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
        let cell: HeroTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = HeroTableViewCellViewModel()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.presentDetail()
    }
}
