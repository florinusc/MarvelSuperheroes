//
//  SquadHeroCollectionViewCellViewModel.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 17.05.2022.
//

import Foundation

class SquadHeroCollectionViewCellViewModel {
    
    private let hero: Superhero
    
    var heroName: String {
        return hero.name
    }
    
    var heroImageURL: URL? {
        return URL(string: hero.imageURL)
    }
    
    init(hero: Superhero) {
        self.hero = hero
    }
    
}

extension SquadHeroCollectionViewCellViewModel: Hashable {
    
    static func == (lhs: SquadHeroCollectionViewCellViewModel, rhs: SquadHeroCollectionViewCellViewModel) -> Bool {
        return lhs.hero == rhs.hero
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(hero)
    }
    
}
