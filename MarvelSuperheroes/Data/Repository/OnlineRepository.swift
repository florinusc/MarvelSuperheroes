//
//  OnlineRepository.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 18.05.2022.
//

import Foundation

class OnlineRepository: Repository {
    
    private let localDataManager: LocalDataManager
    
    init(localDataManager: LocalDataManager) {
        self.localDataManager = localDataManager
    }
    
    func getSuperheroes(offSet: Int, _ handler: @escaping (Result<Superheroes, Error>) -> Void) {
        SessionManager().request(type: HeroesResource.self, requestType: HeroesRequest(offSet: offSet)) { result in
            switch result {
            case .success(let heroesResource):
                handler(.success(Superheroes(resource: heroesResource)))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func getSquadMembers() throws -> [Superhero] {
        try localDataManager.getSquadMembers()
    }
    
    func addSquadMember(hero: Superhero) throws {
        try localDataManager.saveSquadMember(hero: hero)
    }
    
    func removeSquadMember(hero: Superhero) throws {
        try localDataManager.removeSquadMember(hero: hero)
    }
    
}
