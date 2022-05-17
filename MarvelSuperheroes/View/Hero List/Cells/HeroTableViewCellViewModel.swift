//
//  HeroTableViewCellViewModel.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 15.05.2022.
//

import Foundation

class HeroTableViewCellViewModel {
    
    private let hero: Superhero
    
    var imageURL: URL? {
        return URL(string: hero.imageURL)
    }
    
    var heroName: String {
        return hero.name
    }
    
    init(hero: Superhero) {
        self.hero = hero
    }
    
}

extension HeroTableViewCellViewModel: Hashable {
    
    static func == (lhs: HeroTableViewCellViewModel, rhs: HeroTableViewCellViewModel) -> Bool {
        return lhs.hero == rhs.hero
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(hero)
    }
    
}
