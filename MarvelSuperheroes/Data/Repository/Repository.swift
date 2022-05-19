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
