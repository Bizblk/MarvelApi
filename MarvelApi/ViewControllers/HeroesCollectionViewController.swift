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
    var heroes: [Hero]!
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            
            guard let detailVC = segue.destination as? DetailViewController else { return }
            guard  let index = collectionView.indexPathsForSelectedItems?.first else { return }
            detailVC.hero = heroes[index.item]
            
            
            guard let thumbnail = heroes[index.item].thumbnail else { return }
            
            let url = NetworkManager.shared.getImageURL(data: thumbnail)
            
            NetworkManager.shared.fetchImage(url: url) { (image) in
                detailVC.heroImageView.image = image
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HeroCollectionViewCell
        cell.heroNameLabel.text = heroes[indexPath.item].name
        cell.heroImageView.layer.cornerRadius = 15
        guard let thumbnail = heroes[indexPath.item].thumbnail else { return cell }
        
        let url = NetworkManager.shared.getImageURL(data: thumbnail)
        
        NetworkManager.shared.fetchImage(url: url) { (image) in
            cell.heroImageView.image = image
        }
        
        return cell
    }
    
}


extension HeroesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 20, height: 180)
    }
    
    
}
