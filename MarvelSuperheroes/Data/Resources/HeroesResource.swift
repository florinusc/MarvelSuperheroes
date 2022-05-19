//
//  HeroesResource.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 18.05.2022.
//

import Foundation

struct HeroesResource: Decodable {
    
    struct DataResource: Decodable {
        
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [HeroResource]
        
    }
    
    let data: DataResource
    
}
