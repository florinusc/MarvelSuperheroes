//
//  HeroListViewModel.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 15.05.2022.
//

import Foundation

class HeroListViewModel: ViewModel {
    
    private var snapshot = HeroesSnapshot()
    private var squadHeroes = [Superhero]()
    private var heroes = [Superhero]()
    
    var dataSource: HeroesDataSource! {
        didSet {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    init() {
        let hero = Superhero(id: "12343",
                             name: "Iron Man",
                             description: "Strongest avenger",
                             imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg")
        
        self.heroes = [hero]
        
        let heroViewModel = HeroTableViewCellViewModel(hero: hero)
        
        var carouselSnapshot = HeroCarouselSnapshot()
        
        carouselSnapshot.appendSections([.main])
        carouselSnapshot.appendItems(heroes.map { SquadHeroCollectionViewCellViewModel(hero: $0) }, toSection: .main)
        
        let heroCarouselViewModel = HeroCarouselTableViewCellViewModel(snapshot: carouselSnapshot)
        
        snapshot.appendSections([.carousel, .heroes])
        snapshot.appendItems([heroCarouselViewModel], toSection: .carousel)
        snapshot.appendItems([heroViewModel], toSection: .heroes)
        
    }
    
    func detailViewModel(at indexPath: IndexPath) -> HeroDetailViewModel? {
        let hero = heroes[indexPath.row]
        return HeroDetailViewModel(hero: hero)
    }
    
    func carouselDetailViewModel(at index: Int) -> HeroDetailViewModel? {
        let hero = squadHeroes[index]
        return HeroDetailViewModel(hero: hero)
    }
    
}
