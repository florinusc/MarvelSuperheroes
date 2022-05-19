//
//  HeroDetailViewModelTests.swift
//  MarvelSuperheroesTests
//
//  Created by Florin Uscatu on 19.05.2022.
//

import XCTest
@testable import MarvelSuperheroes

class HeroDetailViewModelTests: XCTestCase {
    
    func test_imageURL_isCorrect() {
        let viewModel = createSUT()
        XCTAssertEqual(viewModel.imageURL, URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg"))
    }
    
    func test_name_isCorrect() {
        let viewModel = createSUT()
        XCTAssertEqual(viewModel.name, "Iron Man")
    }
    
    func test_description_isCorrect() {
        let viewModel = createSUT()
        let expectedDescription = "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
        XCTAssertEqual(viewModel.description, expectedDescription)
    }
    
    func test_toggleSquadMemberShip_withoutError_isCorrect() {
        let viewModel = createSUT()
        try? viewModel.toggleSquadMembership()
        XCTAssertEqual(viewModel.inSquad, false)
    }
    
    func test_toggleSquadMemberShip_withError_errorIsThrown() {
        let viewModel = createSUT(true)
        XCTAssertThrowsError(try viewModel.toggleSquadMembership())
    }
    
    func test_toggleSquadMemberShip_withoutError_errorIsNotThrown() {
        let viewModel = createSUT()
        XCTAssertNoThrow(try viewModel.toggleSquadMembership())
    }
    
    private func createSUT(_ withError: Bool = false) -> HeroDetailViewModel {
        let localDataManager = MockLocalDataManager(withError)
        return HeroDetailViewModel(repository: MockRepository(shouldReturnError: withError, localDataManager: localDataManager),
                                   hero: .ironMan,
                                   inSquad: true)
    }
    
}
