//
//  FavoritHeroesTableViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 09.05.2021.
//

import UIKit

class FavoritHeroesTableViewController: UITableViewController {
    
    private var heroes: [Hero] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroes = StorageManager.shared.fetchHeroes()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritCell", for: indexPath) as! FavoritHeroTableViewCell
        
        cell.setupCell(hero: heroes[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            heroes.remove(at: indexPath.row)
            StorageManager.shared.deleteFavoritHero(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
