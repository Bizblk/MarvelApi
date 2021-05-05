//
//  ViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 30.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var publicApiLabel: UIButton!
    
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publicApiLabel.layer.cornerRadius = 15
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let heroesCollectionVC = segue.destination as? HeroesCollectionViewController else { return }
        
        heroesCollectionVC.fetchHero()
        
    }
    
    //MARK: - IB Action
    @IBAction func marvelApiAction(_ sender: Any) {
        
    }
    
}

