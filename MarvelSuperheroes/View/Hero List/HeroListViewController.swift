//
//  HeroListViewController.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 14.05.2022.
//

import UIKit

enum HeroesSection: Int {
    case carousel
    case heroes
}

typealias HeroesDataSource = UITableViewDiffableDataSource<HeroesSection, AnyHashable>
typealias HeroesSnapshot = NSDiffableDataSourceSnapshot<HeroesSection, AnyHashable>

class HeroListViewController: UIViewController, StoryboardViewController, ViewModelBased {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: HeroListViewModel!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getSquadMembers()
    }
    
    private func setUp() {
        navigationController?.navigationBar.isHidden = true
        setUpTableView()
        viewModel.dataSource = createDataSource()
        getSuperheroes()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.register(HeroTableViewCell.self)
        tableView.register(HeroCarouselTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    private func getSuperheroes() {
        let loadingViewController = LoadingViewController()
        add(loadingViewController)
        viewModel.getSuperheroes { [weak self] error in
            loadingViewController.remove()
            if let error = error {
                self?.presentAlert(for: error)
            }
        }
    }
    
    private func getSquadMembers() {
        do {
            try viewModel.getSquadMembers()
        } catch let error {
            presentAlert(for: error)
        }
    }
    
    private func createDataSource() -> HeroesDataSource {
        return HeroesDataSource(tableView: tableView) { (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
            
            if let viewModel = itemIdentifier as? HeroCarouselTableViewCellViewModel {
                let cell: HeroCarouselTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.collectionViewDelegate = self
                cell.viewModel = viewModel
                return cell
            }
                
            
            if let viewModel = itemIdentifier as? HeroTableViewCellViewModel {
                let cell: HeroTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.viewModel = viewModel
                return cell
            }
            
            return nil
            
        }
    }
    
    @IBAction private func tappedMarvelLogo() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }

}

extension HeroListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.getMoreSuperheroes(after: indexPath) { [weak self] handler in
            switch handler {
            case .error(let error):
                self?.presentAlert(for: error)
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let heroDetailViewModel = viewModel.detailViewModel(at: indexPath) else { return }
        coordinator?.presentDetail(with: heroDetailViewModel)
    }
    
}

extension HeroListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let heroDetailViewModel = viewModel.carouselDetailViewModel(at: indexPath.row) else { return }
        coordinator?.presentDetail(with: heroDetailViewModel)
    }
    
}
