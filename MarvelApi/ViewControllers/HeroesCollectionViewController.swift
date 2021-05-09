//
//  HeroesCollectionViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 02.05.2021.
//

import UIKit


class HeroesCollectionViewController: UICollectionViewController {
    
    //MARK: - Public Properties
    var heroes = [Hero]()
    
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHero()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            
            guard let detailVC = segue.destination as? DetailViewController else { return }
            guard  let index = collectionView.indexPathsForSelectedItems?.first else { return }
            detailVC.hero = heroes[index.item]
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HeroCollectionViewCell
        let hero = heroes[indexPath.item]
        cell.setupCell(hero: hero)
        return cell
    }
    
    func fetchHero() {
        DispatchQueue.main.async {
            NetworkManager.shared.fetchHero { (dataHeroes) in
                self.heroes = dataHeroes
                self.collectionView.reloadData()
            }
        }
        
    }
}


extension HeroesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 20, height: 180)
    }
    
    
}
