//
//  MockLocalDataManager.swift
//  MarvelSuperheroesTests
//
//  Created by Florin Uscatu on 19.05.2022.
//

import Foundation
@testable import MarvelSuperheroes

class MockLocalDataManager: LocalDataManager {
    
    private let shouldReturnError: Bool
    
    private var squadMembers: [Superhero] = [.ironMan, .blackWidow]
    
    init(_ shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func saveSquadMember(hero: Superhero) throws {
        if shouldReturnError {
            throw CustomError.general
        }
        squadMembers.append(hero)
    }
    
    func getSquadMembers() throws -> [Superhero] {
        if shouldReturnError {
            throw CustomError.general
        }
        return squadMembers
    }
    
    func removeSquadMember(hero: Superhero) throws {
        if shouldReturnError {
            throw CustomError.general
        }
        guard let index = squadMembers.firstIndex(of: hero) else { throw CustomError.general }
        squadMembers.remove(at: index)
    }
    
}
