//
//  StoryboardViewController.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 15.05.2022.
//

import UIKit

protocol StoryboardViewController {}

extension StoryboardViewController where Self: UIViewController {
    static func getInstance() -> Self {
        let storyboardName = String(describing: Self.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}
