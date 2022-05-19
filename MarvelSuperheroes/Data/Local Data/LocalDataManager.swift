//
//  LocalDataManager.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 18.05.2022.
//

import Foundation

protocol LocalDataManager {
    func saveSquadMember(hero: Superhero) throws
    func getSquadMembers() throws -> [Superhero]
    func removeSquadMember(hero: Superhero) throws
}
