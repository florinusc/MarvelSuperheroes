//
//  HeroCarouselTableViewCellViewModel.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 17.05.2022.
//

import Foundation

class HeroCarouselTableViewCellViewModel {
    
    private var snapshot: HeroCarouselSnapshot
    
    var dataSource: HeroCarouselDataSource? {
        didSet {
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    init(snapshot: HeroCarouselSnapshot) {
        self.snapshot = snapshot
    }
    
    func updateSnapshot(_ newSnapshot: HeroCarouselSnapshot) {
        snapshot = newSnapshot
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
}

extension HeroCarouselTableViewCellViewModel: Hashable {
    
    static func == (lhs: HeroCarouselTableViewCellViewModel, rhs: HeroCarouselTableViewCellViewModel) -> Bool {
        return lhs.snapshot.itemIdentifiers == rhs.snapshot.itemIdentifiers
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(snapshot.itemIdentifiers)
    }
    
}
