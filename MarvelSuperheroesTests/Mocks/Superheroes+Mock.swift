//
//  Superheroes+Mock.swift
//  MarvelSuperheroesTests
//
//  Created by Florin Uscatu on 20.05.2022.
//

import Foundation
@testable import MarvelSuperheroes

extension Superheroes {
    
    static let firstMock = Superheroes(total: 4, heroes: [.ironMan, .blackWidow])
    static let secondMock = Superheroes(total: 4, heroes: [.captainAmerica, .warMachine])
    
}
