//
//  HeroResource.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 18.05.2022.
//

import Foundation

struct HeroResource: Decodable {
    
    struct Thumbnail: Decodable {
        
        let path: String
        let fileExtension: String
        
        enum CodingKeys: String, CodingKey {
            case path
            case fileExtension = "extension"
        }
        
    }
    
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    
}
