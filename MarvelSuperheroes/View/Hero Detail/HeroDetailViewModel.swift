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
    
    private(set) var inSquad: Bool
    
    init(hero: Superhero, inSquad: Bool) {
        self.hero = hero
        self.inSquad = inSquad
    }
    
    func toggleSquadMembership() {
        inSquad = !inSquad
        // TODO: - Update db
    }
    
}
