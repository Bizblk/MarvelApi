//
//  NetworkManager.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 01.05.2021.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    //MARK: - Private Properties
    private let publicKey = "809bc2ac4467a13ea6cd8d68e25a1b46"
    private let privateKey = "c6eb2accce068b5f78dacab01bf8f510f28705e7"
    
    private init() {}
    
    func getImageURL(data: Thumbnail) -> URL {
        let path = data.path ?? ""
        let ext = data.ext ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
    
    func fetchHero(heroes: @escaping ([Hero]) -> Void) {
        
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)") else { return }
        
        AF.request(url)
            .validate()
            .responseJSON { (dataResponse) in
                switch dataResponse.result {
                
                case .success(let value):
                    guard let results = Hero.getHeroes(value: value) else { return }
                    DispatchQueue.main.async {
                        heroes(results)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    func fetchImage(url: URL, imageData: @escaping (Data) -> Void) {
        
        AF.request(url)
            .validate()
            .response { (data) in
                switch data.result {
                case .success(let data):
                    guard let data = data else { return }
                    
                    DispatchQueue.main.async {
                        imageData(data)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchSeries(id: String, series: @escaping ([Series]) -> Void) {
        
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters/\(id)/series?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)") else { return }
        
        AF.request(url)
            .validate()
            .responseJSON { (dataResponse) in
                switch dataResponse.result {
                
                case .success(let value):
                    guard let results = Series.getSeries(value: value) else { return }
                    DispatchQueue.main.async {
                        series(results)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}



