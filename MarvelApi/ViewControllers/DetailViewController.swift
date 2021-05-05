//
//  DetailViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 02.05.2021.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLable: UILabel!
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    
    //MARK: - Public Properties
    var hero: Hero!

    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroNameLable.text = hero.name
        heroDescriptionLabel.text = hero.description
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "series" {
            
            guard let seriesVC = segue.destination as? SeriesTableViewController else { return }
            guard let idSeries = hero.id else { return }
            
            seriesVC.fetchSeries(id: String(idSeries))
            
        }
    }
    
    
}
