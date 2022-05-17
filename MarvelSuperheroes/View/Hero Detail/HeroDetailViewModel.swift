//
//  HeroDetailViewModel.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 16.05.2022.
//

import Foundation

class HeroDetailViewModel: ViewModel {
    
    private let hero: Superhero
    
    var imageURL: URL? {
        return URL(string: hero.imageURL)
    }
    
    var name: String {
        return hero.name
    }
    
    var description: String {
        return hero.description
    }
    
    init(hero: Superhero) {
        self.hero = hero
    }
    
}
