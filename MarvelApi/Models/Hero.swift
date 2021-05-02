//
//  Hero.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 01.05.2021.
//

import Foundation

struct APIResult: Codable {
    let data: APICharacterData
}

struct APICharacterData: Codable {
    let count: Int?
    let results: [Character]
    
}

struct Character: Codable {
    
    let id: Int?
    let name: String?
    let descritpion: String?
    let thumbnail: [String: String]?
    
    
}



struct APIResultHeros: Codable {
    let results: [Hero]
    
}

struct Hero: Codable {
    
    let id: Int?
    let name: String?
    let descritpion: String?
    
}
