//
//  DetailViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 02.05.2021.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet weak var heroImageView: CustomImageView!
    @IBOutlet weak var heroNameLable: UILabel!
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    @IBOutlet weak var addFavoritButton: UIButton!
    
    //MARK: - Public Properties
    var hero: Hero!

    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        heroNameLable.text =  hero.name
        heroDescriptionLabel.text = hero.description
        setupFavoritButton()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "series" {
            
            guard let seriesVC = segue.destination as? SeriesTableViewController else { return }
            guard let idSeries = hero.id else { return }
            
            seriesVC.fetchSeries(id: String(idSeries))
            
        }
    }
    @IBAction func addFavoritButtonAction(_ sender: Any) {
        let favoritHeroes = StorageManager.shared.fetchHeroes()
        
        for indexHero in 0..<favoritHeroes.count {
            if favoritHeroes[indexHero].id == hero.id {
                StorageManager.shared.deleteFavoritHero(index: indexHero)
                addFavoritButton.setImage(UIImage(systemName: "heart"), for: .normal)
                print(favoritHeroes.count)
                return
            }
        }
        StorageManager.shared.saveFavoritHero(hero: hero)
        addFavoritButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        print(favoritHeroes.count)
    }
    
    private func setupFavoritButton() {
        let favoritHeroes = StorageManager.shared.fetchHeroes()
        print(favoritHeroes.count)
        for favoritHero in favoritHeroes {
            if favoritHero.id == hero.id {
                addFavoritButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
        
    }
    
    
    func setupImageView() {
        heroImageView.contentMode = .scaleAspectFit
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = heroImageView.frame.height / 4
        heroImageView.backgroundColor = .white
        heroImageView.fetchImage(url: hero.urlString)
        
    }
    
}
