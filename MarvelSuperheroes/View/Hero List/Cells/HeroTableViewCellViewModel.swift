//
//  HeroTableViewCellViewModel.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 15.05.2022.
//

import Foundation

class HeroTableViewCellViewModel {
    
    var imageURL: URL? {
        return URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg")
    }
    
    var heroName: String {
        return "A.I.M"
    }
    
}
