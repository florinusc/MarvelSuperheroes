//
//  UIImageView+Extension.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 15.05.2022.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func setImage(with url: URL?) {
        guard let url = url else { return }
        af.setImage(withURL: url)
    }
    
}
