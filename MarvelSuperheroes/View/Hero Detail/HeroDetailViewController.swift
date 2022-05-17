//
//  HeroDetailViewController.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 16.05.2022.
//

import UIKit

class HeroDetailViewController: UIViewController, StoryboardViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var toggleButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroImageView.setImage(with: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg"))
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        let selected = false
        
        if selected {
            toggleButton.backgroundColor = .clear
            toggleButton.layer.borderWidth = 3
            toggleButton.layer.borderColor = UIColor(named: "Button")?.cgColor
            toggleButton.setTitle("🔥  Fire from Squad", for: .normal)
        } else {
            toggleButton.layer.masksToBounds = false
            toggleButton.layer.shadowOpacity = 1
            toggleButton.layer.shadowColor = UIColor(named: "Button")?.cgColor
            toggleButton.layer.shadowRadius = 16
            toggleButton.layer.shadowOffset = CGSize(width: 0, height: 4)
            toggleButton.setTitle("💪  Recruit to Squad", for: .normal)
        }
    }
    
    @IBAction private func backButtonTapped() {
        coordinator?.dismissDetail()
    }
    
}
