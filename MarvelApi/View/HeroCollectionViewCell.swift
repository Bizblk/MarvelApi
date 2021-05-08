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
    
    private var spinnerView: UIActivityIndicatorView!
    
    // MARK: - Public methods
    func setupCell(hero: Hero?) {
        
        heroImageView.layer.cornerRadius = 15
        heroNameLabel.text = hero?.name
        spinnerView = showSpinner(in: contentView)
        
        
        DispatchQueue.global().async {
            guard let thumbnail = hero?.thumbnail else { return }
            let imageUrl = NetworkManager.shared.getImageURL(data: thumbnail)
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.heroImageView.image = UIImage(data: imageData)
                self.spinnerView.stopAnimating()
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
}
