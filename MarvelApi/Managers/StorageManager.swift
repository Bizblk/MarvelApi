//
//  StorageManager.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 09.05.2021.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    private let key = "heroes"
    
    private init() {}
    
    
    
    func saveFavoritHero(hero: Hero) {
        
        var favoritHeroes = fetchHeroes()
        favoritHeroes.append(hero)
        guard let data = try? JSONEncoder().encode(favoritHeroes) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func fetchHeroes() -> [Hero] {
        
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return [] }
        guard let heroes = try? JSONDecoder().decode([Hero].self, from: data) else { return [] }
        return heroes
    }
    
    func deleteFavoritHero(index: Int) {
        var favoritHeroes = fetchHeroes()
        favoritHeroes.remove(at: index)
        guard let data = try? JSONEncoder().encode(favoritHeroes) else { return }
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
}
