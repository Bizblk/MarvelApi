//
//  Series.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 01.05.2021.
//

import Foundation

struct APISeries: Codable {
    let data: APISeriesData
}

struct APISeriesData: Codable {
    let count: Int?
    let results: [Series]
    
}


struct Series: Codable {
   
    let id: Int?
    let title: String?
    let description: String?
    let rating: String?
    let thumbnail: [String: String]?
    
}

struct Thumbnail: Codable {
    let path: String?
    var ext = "jpg"
}
