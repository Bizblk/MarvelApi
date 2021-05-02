//
//  NetworkManager.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 01.05.2021.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    //MARK: - Private Properties
    private let publicKey = "809bc2ac4467a13ea6cd8d68e25a1b46"
    private let privateKey = "c6eb2accce068b5f78dacab01bf8f510f28705e7"
    
    
    
    func getImageURL(data: [String: String]) -> URL {
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
    
    
    func fetchHero(heroess: @escaping ([Hero]) -> Void) {
        var heroes = [Hero]()
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = "\(ts)\(privateKey)\(publicKey)".MD5
        
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
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
    
    func fetchImage(url: URL, image: @escaping (UIImage) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            print(response)
            guard let dataImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                image(dataImage)
                print(dataImage)
            }
            
        }.resume()
        
    }
    
    private init() {}
}



