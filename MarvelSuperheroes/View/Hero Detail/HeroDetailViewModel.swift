//
//  HeroDetailViewModel.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 16.05.2022.
//

import Foundation

class HeroDetailViewModel: ViewModel {
    
    private let repository: Repository
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
    
    init(repository: Repository, hero: Superhero, inSquad: Bool) {
        self.repository = repository
        self.hero = hero
        self.inSquad = inSquad
    }
    
    func toggleSquadMembership() {
        if inSquad {
            repository.removeSquadMember(hero: hero)
        } else {
            repository.addSquadMember(hero: hero)
        }
        inSquad = !inSquad
    }
    
}
