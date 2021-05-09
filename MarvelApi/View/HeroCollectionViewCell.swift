//
//  HeroCollectionViewCell.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 02.05.2021.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var heroImageView: CustomImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    
    // MARK: - Public methods
    func setupCell(hero: Hero?) {
        
        heroImageView.layer.cornerRadius = 15
        heroNameLabel.text = hero?.name
        
        DispatchQueue.main.async {
            guard let urlString = hero?.urlString else { return }
            self.heroImageView.fetchImage(url: urlString)
        }
    }
}
