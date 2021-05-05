//
//  HeroCollectionViewCell.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 02.05.2021.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    
    // MARK: - Public methods
    func setupCell(hero: Hero?) {
        
        heroImageView.layer.cornerRadius = 15
        heroNameLabel.text = hero?.name
        
        DispatchQueue.global().async {
            guard let thumbnail = hero?.thumbnail else { return }
            let imageUrl = NetworkManager.shared.getImageURL(data: thumbnail)
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.heroImageView.image = UIImage(data: imageData)
            }
        }
    }
    
}
