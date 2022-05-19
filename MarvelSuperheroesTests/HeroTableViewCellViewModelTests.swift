//
//  HeroTableViewCellViewModelTests.swift
//  MarvelSuperheroesTests
//
//  Created by Florin Uscatu on 19.05.2022.
//

import XCTest
@testable import MarvelSuperheroes

class HeroTableViewCellViewModelTests: XCTestCase {
    
    private let hero = Superhero.ironMan
    
    func test_imageURL_isCorrect() {
        let viewModel = HeroTableViewCellViewModel(hero: hero)
        XCTAssertEqual(viewModel.imageURL, URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg"))
    }
    
    func test_name_isCorrect() {
        let viewModel = HeroTableViewCellViewModel(hero: hero)
        XCTAssertEqual(viewModel.heroName, "Iron Man")
    }
    
}
