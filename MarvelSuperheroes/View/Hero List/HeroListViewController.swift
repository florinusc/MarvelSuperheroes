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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HeroTableViewCell.self)
        
    }

}

extension HeroListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HeroTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = HeroTableViewCellViewModel()
        return cell
    }
}
