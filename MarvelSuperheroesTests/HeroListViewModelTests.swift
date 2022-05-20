//
//  HeroListViewModelTests.swift
//  MarvelSuperheroesTests
//
//  Created by Florin Uscatu on 19.05.2022.
//

import XCTest
@testable import MarvelSuperheroes

class HeroListViewModelTests: XCTestCase {
    
    func test_getSuperheroes_withoutRepositoryError_errorIsNil() {
        var expectedError: Error?
        let expectation = XCTestExpectation()
        createSUT().getSuperheroes { error in
            expectedError = error
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        XCTAssertNil(expectedError)
    }
    
    func test_getSuperheroes_withRepositoryError_errorIsNotNil() {
        var expectedError: Error?
        let expectation = XCTestExpectation()
        createSUT(true).getSuperheroes { error in
            expectedError = error
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(expectedError)
    }
    
    func test_getSquadMembers_withoutRepositoryManager_errorIsNotThrown() {
        XCTAssertNoThrow(try createSUT().getSquadMembers())
    }
    
    func test_getSquadMembers_withRepositoryManager_errorIsThrown() {
        XCTAssertThrowsError(try createSUT(true).getSquadMembers())
    }
    
    func test_detailViewModel_atValidIndexPath_isNotNil() {
        let viewModel = createSUT()
        getSuperheroes(for: viewModel)
        let detailViewModel = viewModel.detailViewModel(at: IndexPath(row: 1, section: 0))
        XCTAssertNotNil(detailViewModel)
    }
        
    func test_detailViewModel_atInvalidIndexPath_isNil() {
        let viewModel = createSUT()
        getSuperheroes(for: viewModel)
        let detailViewModel = viewModel.detailViewModel(at: IndexPath(row: 5, section: 5))
        XCTAssertNil(detailViewModel)
    }
    
    func test_carouselDetailViewModel_atValidIndex_isNotNil() {
        let viewModel = createSUT()
        try? viewModel.getSquadMembers()
        let carouselDetailViewModel = viewModel.carouselDetailViewModel(at: 0)
        XCTAssertNotNil(carouselDetailViewModel)
    }
    
    func test_carouselDetailViewModel_atInvalidIndex_isNil() {
        let viewModel = createSUT()
        try? viewModel.getSquadMembers()
        let carouselDetailViewModel = viewModel.carouselDetailViewModel(at: 5)
        XCTAssertNil(carouselDetailViewModel)
    }
    
    func test_getMoreSuperheroes_beforeLoadingAllHeroes() {
        let viewModel = createSUT()
        var expectedHandler: HeroListViewModel.LoadMoreHandler?
        let expectation = XCTestExpectation()
        getSuperheroes(for: viewModel)
        viewModel.getMoreSuperheroes(after: IndexPath(row: 1, section: 0)) { handler in
            expectedHandler = handler
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        guard case .loading = expectedHandler else {
            XCTFail()
            return
        }
    }
    
    func test_getMoreSuperheroes_afterLoadingAllHeroes() {
        let viewModel = createSUT()
        var expectedHandler: HeroListViewModel.LoadMoreHandler?
        let expectation = XCTestExpectation()
        getSuperheroes(for: viewModel)
        viewModel.getMoreSuperheroes(after: IndexPath(row: 4, section: 0)) { handler in
            expectedHandler = handler
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        guard case .notRequired = expectedHandler else {
            XCTFail()
            return
        }
    }
    
    private func getSuperheroes(for viewModel: HeroListViewModel) {
        let expectation = XCTestExpectation()
        viewModel.getSuperheroes { error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    private func createSUT(_ withError: Bool = false) -> HeroListViewModel {
        let localDataManager = MockLocalDataManager(withError)
        return HeroListViewModel(repository: MockRepository(shouldReturnError: withError, localDataManager: localDataManager))
    }
    
}
