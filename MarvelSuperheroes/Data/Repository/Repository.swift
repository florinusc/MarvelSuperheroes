//
//  Repository.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 17.05.2022.
//

import Foundation

protocol Repository {
    func getSuperheroes(_ handler: @escaping (Result<[Superhero], Error>) -> Void)
    func getSquadMembers() throws -> [Superhero]
    func addSquadMember(hero: Superhero) throws
    func removeSquadMember(hero: Superhero) throws
}

class MockRepository: Repository {
    
    private let shouldReturnError: Bool
    
    private let heroes = [Superhero(id: "1009368",
                                    name: "Iron Man",
                                    description: "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man.",
                                    imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg"),
                          Superhero(id: "1009189",
                                    name: "Black Widow",
                                    description: "",
                                    imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/f/30/50fecad1f395b.jpg")]
    
    private var squadMembers = [Superhero(id: "1009368",
                                          name: "Iron Man",
                                          description: "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man.",
                                          imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg"),
                                Superhero(id: "1009189",
                                          name: "Black Widow",
                                          description: "",
                                          imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/f/30/50fecad1f395b.jpg")]
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func getSuperheroes(_ handler: @escaping (Result<[Superhero], Error>) -> Void) {
        if shouldReturnError {
            handler(.failure(CustomError.general))
            return
        }
        handler(.success(heroes))
    }
    
    func getSquadMembers() throws -> [Superhero] {
        if shouldReturnError {
            throw CustomError.general
        }
        return squadMembers
    }
    
    func addSquadMember(hero: Superhero) throws {
        squadMembers.insert(hero, at: 0)
    }
    
    func removeSquadMember(hero: Superhero) throws {
        guard let index = squadMembers.firstIndex(of: hero) else { throw CustomError.general }
        squadMembers.remove(at: index)
    }
    
}
