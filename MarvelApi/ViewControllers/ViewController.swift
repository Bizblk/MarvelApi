//
//  ViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 30.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var publicApiLabel: UIButton!
    
    //MARK: - Private Properties
    private var heroes = [Hero]()
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publicApiLabel.layer.cornerRadius = 15
        NetworkManager.shared.fetchHero { (heroess) in
            self.heroes = heroess
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let heroesCollectionVC = segue.destination as? HeroesCollectionViewController else { return }
        
        heroesCollectionVC.heroes = self.heroes
    }
    
    //MARK: - IB Action
    @IBAction func marvelApiAction(_ sender: Any) {
        
    }
    
}

