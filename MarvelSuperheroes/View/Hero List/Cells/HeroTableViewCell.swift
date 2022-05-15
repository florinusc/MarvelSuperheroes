//
//  HeroTableViewCell.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 15.05.2022.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var heroLabel: UILabel!
    
    var viewModel: HeroTableViewCellViewModel? {
        didSet {
            heroImageView.setImage(with: viewModel?.imageURL)
            heroLabel.text = viewModel?.heroName
        }
    }
    
}
