//
//  MockRepository.swift
//  MarvelSuperheroesTests
//
//  Created by Florin Uscatu on 19.05.2022.
//

import Foundation
@testable import MarvelSuperheroes

class MockRepository: Repository {
    
    private let shouldReturnError: Bool
    
    private let localDataManager: LocalDataManager
    
    init(shouldReturnError: Bool = false, localDataManager: LocalDataManager) {
        self.shouldReturnError = shouldReturnError
        self.localDataManager = localDataManager
    }
    
    func getSuperheroes(offSet: Int, _ handler: @escaping (Result<Superheroes, Error>) -> Void) {
        if shouldReturnError {
            handler(.failure(CustomError.general))
            return
        }
        var heroes: Superheroes {
            if offSet <= 2 {
                return .firstMock
            } else {
                return .secondMock
            }
        }
        handler(.success(heroes))
    }
    
    func getSquadMembers() throws -> [Superhero] {
        return try localDataManager.getSquadMembers()
    }
    
    func addSquadMember(hero: Superhero) throws {
        try localDataManager.saveSquadMember(hero: hero)
    }
    
    func removeSquadMember(hero: Superhero) throws {
        try localDataManager.removeSquadMember(hero: hero)
    }
    
}
