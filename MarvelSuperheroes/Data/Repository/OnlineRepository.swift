//
//  OnlineRepository.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 18.05.2022.
//

import Foundation

class OnlineRepository: Repository {
    
    func getSuperheroes(_ handler: @escaping (Result<[Superhero], Error>) -> Void) {
        SessionManager().request(type: HeroesResource.self, requestType: HeroesRequest()) { result in
            switch result {
            case .success(let heroesResource):
                handler(.success(heroesResource.data.results.map { Superhero(resource: $0) }))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func getSquadMembers() throws -> [Superhero] {
        try LocalDataManager().getSquadMembers()
    }
    
    func addSquadMember(hero: Superhero) throws {
        try LocalDataManager().saveSquadMember(hero: hero)
    }
    
    func removeSquadMember(hero: Superhero) throws {
        try LocalDataManager().removeSquadMember(hero: hero)
    }
    
}
