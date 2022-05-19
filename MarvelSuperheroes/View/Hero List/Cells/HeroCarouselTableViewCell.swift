//
//  HeroCarouselTableViewCell.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 16.05.2022.
//

import UIKit

enum HeroCarouselSection: Int {
    case main
}

typealias HeroCarouselDataSource = UICollectionViewDiffableDataSource<HeroCarouselSection, SquadHeroCollectionViewCellViewModel>
typealias HeroCarouselSnapshot = NSDiffableDataSourceSnapshot<HeroCarouselSection, SquadHeroCollectionViewCellViewModel>

class HeroCarouselTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: HeroCarouselTableViewCellViewModel! {
        didSet {
            viewModel.dataSource = createDataSource()
        }
    }
    var collectionViewDelegate: UICollectionViewDelegate? {
        didSet {
            collectionView.delegate = collectionViewDelegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(SquadHeroCollectionViewCell.self)
    }
    
    private func createDataSource() -> HeroCarouselDataSource {
        return HeroCarouselDataSource(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell: SquadHeroCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.viewModel = itemIdentifier
            return cell
        }
    }
    
}
