//
//  Superheroes+Mock.swift
//  MarvelSuperheroesTests
//
//  Created by Florin Uscatu on 20.05.2022.
//

import Foundation
@testable import MarvelSuperheroes

extension Superheroes {
    
    static let mock = Superheroes(total: 2, heroes: [.ironMan, .blackWidow])
    
}
