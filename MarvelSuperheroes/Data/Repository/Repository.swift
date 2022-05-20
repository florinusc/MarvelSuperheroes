//
//  Repository.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 17.05.2022.
//

import Foundation

protocol Repository {
    func getSuperheroes(offSet: Int, _ handler: @escaping (Result<Superheroes, Error>) -> Void)
    func getSquadMembers() throws -> [Superhero]
    func addSquadMember(hero: Superhero) throws
    func removeSquadMember(hero: Superhero) throws
}
