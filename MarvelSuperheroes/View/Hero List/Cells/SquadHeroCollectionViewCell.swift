//
//  SquadHeroCollectionViewCell.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 16.05.2022.
//

import UIKit

class SquadHeroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var heroLabel: UILabel!
    
    var viewModel: SquadHeroCollectionViewCellViewModel! {
        didSet {
            setUp(with: viewModel)
        }
    }
    
    private func setUp(with viewModel: SquadHeroCollectionViewCellViewModel) {
        heroLabel.text = viewModel.heroName
        heroImageView.setImage(with: viewModel.heroImageURL)
    }
    
}
