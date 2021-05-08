//
//  Series.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 01.05.2021.
//

import Foundation

struct Series: Codable {
   
    let id: Int?
    let title: String?
    let description: String?
    let rating: String?
    let thumbnail: Thumbnail?
    
    
    init(dict: [String: Any]) {
        id = dict["id"] as? Int
        title = dict["title"] as? String
        description = dict["description"] as? String
        rating = dict["rating"] as? String
        
        let thumbnailDict = dict["thumbnail"] as? [String: String] ?? [:]
        thumbnail = Thumbnail(dict: thumbnailDict)
    }
    
    static func getSeries(value: Any) -> [Series]? {
        
        guard let value = value as? [String : Any] else { return [] }
        guard let data = value["data"] as? [String : Any] else { return [] }
        guard let results = data["results"] as? [[String: Any]] else { return [] }
        return results.compactMap { Series(dict: $0)}
    }
    
}


struct Hero: Codable {
    
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Thumbnail?
    
    
    init(dict: [String: Any]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        description = dict["description"] as? String
        let thumbnailDict = dict["thumbnail"] as? [String: String] ?? [:]
        thumbnail = Thumbnail(dict: thumbnailDict)
    }
    
    static func getHeroes(value: Any) -> [Hero]? {
        
        guard let value = value as? [String : Any] else { return [] }
        guard let data = value["data"] as? [String : Any] else { return [] }
        guard let results = data["results"] as? [[String: Any]] else { return [] }
        return results.compactMap { Hero(dict: $0)}
     
    }
    
    
}


struct Thumbnail: Codable {
    let path: String?
    var ext: String?
    
    init(dict: [String: Any]) {
        path = dict["path"] as? String
        ext = dict["extension"] as? String
    }
    
}
