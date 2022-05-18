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
    
    var dataSource: HeroesDataSource! {
        didSet {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getData(_ handler: @escaping (Error?) -> Void) {
        var squadError: Error?
        var heroesError: Error?
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        repository.getSquadMembers { [weak self] result in
            guard let self = self else { return }
            dispatchGroup.leave()
            switch result {
            case .failure(let error):
                squadError = error
            case .success(let squadMembers):
                if squadMembers != self.squadHeroes {
                    self.squadHeroes = squadMembers
                }
            }
        }
        dispatchGroup.enter()
        repository.getSuperheroes { [weak self] result in
            guard let self = self else { return }
            dispatchGroup.leave()
            switch result {
            case .failure(let error):
                heroesError = error
            case .success(let heroes):
                if heroes != self.heroes {
                    self.heroes = heroes
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.handleErrors(squadError: squadError, heroesError: heroesError, handler)
        }
    }
    
    func detailViewModel(at indexPath: IndexPath) -> HeroDetailViewModel? {
        let hero = heroes[indexPath.row]
        return HeroDetailViewModel(repository: repository, hero: hero, inSquad: squadHeroes.contains(where: { $0 == hero }))
    }
    
    func carouselDetailViewModel(at index: Int) -> HeroDetailViewModel? {
        let hero = squadHeroes[index]
        return HeroDetailViewModel(repository: repository, hero: hero, inSquad: true)
    }
    
    private func handleErrors(squadError: Error?, heroesError: Error?, _ handler: @escaping (Error?) -> Void) {
        if squadError == nil && heroesError == nil {
            handler(nil)
        } else if squadError != nil && heroesError != nil {
            handler(CustomError.custom(message: "Could not retrieve heroes and squad members"))
        } else if squadError == nil && heroesError != nil {
            handler(CustomError.custom(message: "Could not retrieve heroes"))
        } else if squadError != nil && heroesError == nil {
            handler(CustomError.custom(message: "Could not retrieve squad members"))
        }
    }
    
    private func updateDataSourceWithSquad() {
        carouselSnapshot.deleteSections([.main])
        snapshot.deleteSections([.carousel])
        if !squadHeroes.isEmpty {
            carouselSnapshot.appendSections([.main])
            carouselSnapshot.appendItems(squadHeroes.map { SquadHeroCollectionViewCellViewModel(hero: $0) }, toSection: .main)
            let heroCarouselViewModel = HeroCarouselTableViewCellViewModel(snapshot: carouselSnapshot)
            
            if snapshot.indexOfSection(.heroes) != nil {
                snapshot.insertSections([.carousel], beforeSection: .heroes)
            } else {
                snapshot.appendSections([.carousel])
            }
            
            snapshot.appendItems([heroCarouselViewModel], toSection: .carousel)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateDataSourceWithHeroViewModels() {
        snapshot.deleteSections([.heroes])
        snapshot.appendSections([.heroes])
        snapshot.appendItems(heroViewModels, toSection: .heroes)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
