//
//  Hero.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 01.05.2021.
//

import Foundation

struct APIResult: Codable {
    let data: APIHeroesData
}

struct APIHeroesData: Codable {
    let count: Int?
    let results: [Hero]
    
}

struct Hero: Codable {
    
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: [String: String]?
    //let thumbnail2: Thumbnail?
    
    
    init(heroDate: [String: Any]) {
        id = heroDate["id"] as? Int
        name = heroDate["name"] as? String
        description = heroDate["description"] as? String
        thumbnail = heroDate["thumbnail"] as? [String: String]
    }
    
    static func getHeroes(value: Any) -> [Hero] {
        
        guard let heroesData = value as? [[String: Any]] else { return [] }
        
        var heroes = [Hero]()
        
        for heroData in heroesData {
            let hero = Hero(heroDate: heroData)
            heroes.append(hero)
        }
        return heroes
    }
    
    
}

//struct Thumbnail: Codable {
//    let path: String
//    let thumbnailExtension: Extension
//}
//
//enum Extension: String, Codable {
//    case gif = "gif"
//    case jpg = "jpg"
//}


