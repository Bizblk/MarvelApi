//
//  FavoritHeroTableViewCell.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 09.05.2021.
//

import UIKit

class FavoritHeroTableViewCell: UITableViewCell {

    @IBOutlet weak var imageHeroView: CustomImageView!
    @IBOutlet weak var heroNameLabel: UILabel!

    func setupCell(hero: Hero?) {
        heroNameLabel.text = hero?.name
        
        imageHeroView.contentMode = .scaleAspectFit
        imageHeroView.clipsToBounds = true
        imageHeroView.layer.cornerRadius = imageHeroView.frame.height / 2
        imageHeroView.backgroundColor = .white
        
        DispatchQueue.main.async {
            guard let urlString = hero?.urlString else { return }
            self.imageHeroView.fetchImage(url: urlString)
        }
    }
    
    
}
