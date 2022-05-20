//
//  Superheroes.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 20.05.2022.
//

import Foundation

struct Superheroes {
    
    let total: Int
    let heroes: [Superhero]
    
}

extension Superheroes {
    
    init(resource: HeroesResource) {
        total = resource.data.total
        heroes = resource.data.results.map { Superhero(resource: $0) }
    }
    
}
