//
//  DetailSeriesViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 05.05.2021.
//

import UIKit

class DetailSeriesViewController: UIViewController {
    
    @IBOutlet weak var imageSeriesView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var series: Series!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        titleLabel.text = series.title
        ratingLabel.text = series.rating
        descriptionLabel.text = series.description
    }
    
    
    func fetchImage() {
        guard let thumbnail = series.thumbnail else { return }
        let url = NetworkManager.shared.getImageURL(data: thumbnail)
        
        NetworkManager.shared.fetchImage(url: url) { (dataImage) in
            self.imageSeriesView.image = UIImage(data: dataImage)
        }
    }
   
}
