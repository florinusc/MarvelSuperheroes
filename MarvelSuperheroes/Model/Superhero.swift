//
//  Superhero.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 17.05.2022.
//

import Foundation

struct Superhero: Hashable {
    
    let id: String
    let name: String
    let description: String
    let imageURL: String
    
}

extension Superhero {
    
    init(resource: HeroResource) {
        self.id = "\(resource.id)"
        self.name = resource.name
        self.description = resource.description
        self.imageURL = "\(resource.thumbnail.path).\(resource.thumbnail.fileExtension)"
    }
    
}
