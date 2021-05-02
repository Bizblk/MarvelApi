//
//  ViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 30.04.2021.
//

import UIKit
import CryptoKit

class ViewController: UIViewController {
   
    var heroes = [Character]()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchHero { (heroess) in
            self.heroes = heroess
        }
        
        print(heroes.count)
        
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let heroesCollectionVC = segue.destination as? HeroesCollectionViewController else { return }
        
        heroesCollectionVC.heroes = self.heroes
    }


    @IBAction func marvelApiAction(_ sender: Any) {
        NetworkManager.shared.fetchHero { (heroess) in
            self.heroes = heroess
        }
        
        print(heroes.count)
        print(heroes[10].name)
     
    }
    
}

