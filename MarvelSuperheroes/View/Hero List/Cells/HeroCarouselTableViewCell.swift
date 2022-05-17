//
//  HeroCarouselTableViewCell.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 16.05.2022.
//

import UIKit

class HeroCarouselTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SquadHeroCollectionViewCell.self)
    }
    
}

extension HeroCarouselTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SquadHeroCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
}
