//
//  HeroesCollectionViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 02.05.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class HeroesCollectionViewController: UICollectionViewController {
    
    //MARK: - Public Properties
    var heroes = [Hero]()
    
    private var spinnerView: UIActivityIndicatorView!
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        NetworkManager.shared.fetchHero { (dataHeroes) in
            self.heroes = dataHeroes
            self.collectionView.reloadData()
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


extension HeroesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 20, height: 180)
    }
    
    
}
