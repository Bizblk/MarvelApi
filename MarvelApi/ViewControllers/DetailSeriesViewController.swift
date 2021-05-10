//
//  DetailSeriesViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 05.05.2021.
//

import UIKit

class DetailSeriesViewController: UIViewController {
    
    @IBOutlet weak var imageSeriesView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var series: Series!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = series.title
        ratingLabel.text = series.rating
        descriptionLabel.text = series.description
        
        DispatchQueue.main.async {
            self.imageSeriesView.fetchImage(url: self.series.urlString)
        }
    }
   
}
