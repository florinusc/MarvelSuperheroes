//
//  HeroDetailViewController.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 16.05.2022.
//

import UIKit

class HeroDetailViewController: UIViewController, StoryboardViewController, ViewModelBased {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var toggleButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var viewModel: HeroDetailViewModel!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        scrollView.contentInsetAdjustmentBehavior = .never
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        heroImageView.setImage(with: viewModel.imageURL)
        toggleButton.layer.masksToBounds = false
        toggleButton.layer.shadowColor = UIColor.button.cgColor
        toggleButton.layer.shadowRadius = 16
        toggleButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        if viewModel.inSquad {
            setButtonForMember()
        } else {
            setButtonForNonMember()
        }
    }
    
    private func setButtonForMember() {
        toggleButton.backgroundColor = .clear
        toggleButton.layer.shadowOpacity = 0
        toggleButton.layer.borderWidth = 3
        toggleButton.layer.borderColor = UIColor.button.cgColor
        toggleButton.setTitle("🔥  Fire from Squad", for: .normal)
    }
    
    private func setButtonForNonMember() {
        toggleButton.backgroundColor = UIColor.button
        toggleButton.layer.shadowOpacity = 1
        toggleButton.setTitle("💪  Recruit to Squad", for: .normal)
    }
    
    private func toggleSquadMembership() {
        viewModel.toggleSquadMembership()
        UIView.animate(withDuration: 0.5) {
            if self.viewModel.inSquad {
                self.setButtonForMember()
            } else {
                self.setButtonForNonMember()
            }
        }
    }
    
    private func presentConfirmationAlert() {
        let alert = UIAlertController(title: "Fire from squad", message: "Are you sure you want to fire \(viewModel.name) from squad?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "🔥 Yes", style: .default, handler: { [weak self] _ in
            self?.toggleSquadMembership()
        })
        let noAction = UIAlertAction(title: "No", style: .default)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func toggleButtonTapped() {
        if viewModel.inSquad {
            presentConfirmationAlert()
        } else {
            toggleSquadMembership()
        }
    }
    
    @IBAction private func backButtonTapped() {
        coordinator?.dismissDetail()
    }
    
}
