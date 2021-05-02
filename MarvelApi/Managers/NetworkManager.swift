//
//  NetworkManager.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 01.05.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let publicKey = "809bc2ac4467a13ea6cd8d68e25a1b46"
    let privateKey = "c6eb2accce068b5f78dacab01bf8f510f28705e7"
    
    func fetchHero(heroess: @escaping ([Character]) -> Void) {
        var heroes = [Character]()
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = "\(ts)\(privateKey)\(publicKey)".MD5
        
        let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)")
        let session = URLSession(configuration: .default)
        session.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else {
                print("no data")
                return
            }
            
            do {
                let characters = try JSONDecoder().decode(APIResult.self, from: APIData)
                
                DispatchQueue.main.async {
                    heroes.append(contentsOf: characters.data.results)
                    heroess(heroes)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
        .resume()
    }

    private init() {}
}



