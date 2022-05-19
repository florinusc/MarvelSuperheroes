//
//  HeroListViewModel.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 15.05.2022.
//

import Foundation

class HeroListViewModel: ViewModel {
    
    private let repository: Repository
    
    private var snapshot = HeroesSnapshot()
    
    private var carouselSnapshot = HeroCarouselSnapshot()
    
    private var squadHeroes = [Superhero]() {
        didSet {
            updateDataSourceWithSquad()
        }
    }
    
    private var heroes = [Superhero]() {
        didSet {
            heroViewModels = heroes.map { HeroTableViewCellViewModel(hero: $0) }
        }
    }
    
    private var heroViewModels = [HeroTableViewCellViewModel]() {
        didSet {
            updateDataSourceWithHeroViewModels()
        }
    }
    
    var dataSource: HeroesDataSource? {
        didSet {
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getSuperheroes(_ handler: @escaping (Error?) -> Void) {
        repository.getSuperheroes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                handler(error)
            case .success(let heroes):
                self.heroes = heroes
                handler(nil)
            }
        }
    }
    
    func getSquadMembers() {
        let squadMembers = (try? repository.getSquadMembers()) ?? []
        self.squadHeroes = squadMembers.sorted(by: { $0.name < $1.name })
    }
    
    func detailViewModel(at indexPath: IndexPath) -> HeroDetailViewModel? {
        let hero = heroes[indexPath.row]
        return HeroDetailViewModel(repository: repository, hero: hero, inSquad: squadHeroes.contains(where: { $0 == hero }))
    }
    
    func carouselDetailViewModel(at index: Int) -> HeroDetailViewModel? {
        let hero = squadHeroes[index]
        return HeroDetailViewModel(repository: repository, hero: hero, inSquad: true)
    }
    
    private func refreshCarouselSnapshot() {
        carouselSnapshot.deleteSections([.main])
        carouselSnapshot.appendSections([.main])
        carouselSnapshot.appendItems(squadHeroes.map { SquadHeroCollectionViewCellViewModel(hero: $0) }, toSection: .main)
    }
    
    private func updateDataSourceWithSquad() {
        let existingCarousel = snapshot.indexOfSection(.carousel) != nil
        if existingCarousel {
            updateCarousel()
        } else {
            addCarousel()
        }
    }
    
    private func addCarousel() {
        guard !squadHeroes.isEmpty else { return }
        refreshCarouselSnapshot()
        let heroCarouselViewModel = HeroCarouselTableViewCellViewModel(snapshot: carouselSnapshot)
        if snapshot.indexOfSection(.heroes) != nil {
            snapshot.insertSections([.carousel], beforeSection: .heroes)
        } else {
            snapshot.appendSections([.carousel])
        }
        snapshot.appendItems([heroCarouselViewModel], toSection: .carousel)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateCarousel() {
        if squadHeroes.isEmpty {
            snapshot.deleteSections([.carousel])
            dataSource?.apply(snapshot, animatingDifferences: true)
        } else {
            refreshCarouselSnapshot()
            guard let carouselSectionIndex = snapshot.indexOfSection(.carousel) else { return }
            let carouselIndexPath = IndexPath(row: 0, section: carouselSectionIndex)
            let heroCarouselViewModel = dataSource?.itemIdentifier(for: carouselIndexPath) as? HeroCarouselTableViewCellViewModel
            heroCarouselViewModel?.updateSnapshot(carouselSnapshot)
        }
    }
    
    private func updateDataSourceWithHeroViewModels() {
        snapshot.deleteSections([.heroes])
        snapshot.appendSections([.heroes])
        snapshot.appendItems(heroViewModels, toSection: .heroes)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
}
