//
//  Superhero+Mock.swift
//  MarvelSuperheroesTests
//
//  Created by Florin Uscatu on 19.05.2022.
//

import Foundation
@testable import MarvelSuperheroes

extension Superhero {
    
    static let ironMan = Superhero(id: "1009368",
                                   name: "Iron Man",
                                   description: "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man.",
                                   imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg")
    
    static let blackWidow = Superhero(id: "1009189",
                                      name: "Black Widow",
                                      description: "",
                                      imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/f/30/50fecad1f395b.jpg")
    
    static let captainAmerica = Superhero(id: "1009134",
                                          name: "Captain America",
                                          description: "",
                                          imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/f/30/50fecad1f395b.jpg")
    
    static let warMachine = Superhero(id: "1039134",
                                      name: "War Machine",
                                      description: "",
                                      imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/f/30/50fecad1f395b.jpg")
    
}
