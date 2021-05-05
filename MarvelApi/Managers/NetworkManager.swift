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
    
    func getImageURL(data: [String: String]) -> URL {
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
    
    
    func fetchHero(heroess: @escaping ([Hero]) -> Void) {
        var heroes = [Hero]()
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        
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
        
        var seriess = [Series]()
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters/\(id)/series?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)") else { return }
        
        AF.request(url)
            .validate()
            .responseJSON { (dataResponse) in
                switch dataResponse.result {
                
                case .success(let value):
                    guard let response = value as? [String: Any] else { return }
                    guard let data = response["data"] as? [String : Any] else { return }
                    guard let dataResults = data["results"] as? [[String: Any]] else { return }
                    
                    for seriesData in dataResults {
                        let series = Series(id: seriesData["id"] as? Int,
                                            title: seriesData["title"] as? String,
                                            description: seriesData["description"] as? String,
                                            rating: seriesData["rating"] as? String,
                                            thumbnail: seriesData["thumbnail"] as? [String: String]
                                            
                                            
                        )
                        seriess.append(series)
                    }
                    
                    DispatchQueue.main.async {
                        series(seriess)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}



