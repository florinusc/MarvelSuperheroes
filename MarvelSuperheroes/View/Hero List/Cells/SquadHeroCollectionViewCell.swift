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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heroImageView.setImage(with: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg"))
        
    }
    
}
