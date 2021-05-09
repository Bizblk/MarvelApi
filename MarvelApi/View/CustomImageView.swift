//
//  CustomImageView.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 08.05.2021.
//

import UIKit

class CustomImageView: UIImageView {
    
    
    func fetchImage(url: String) {
        
        guard let imageUrl = URL(string: url) else {
            image = #imageLiteral(resourceName: "marvel")
            return
        }
        
        if let cacheImage = getCacheImage(url: imageUrl) {
            image = cacheImage
            return
        }
        
        NetworkManager.shared.fetchImage(url: imageUrl) { (data, response) in
            self.image = UIImage(data: data)
            self.saveDataToCache(date: data, response: response)
        }
        
    }
    
    private func saveDataToCache(date: Data, response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: date)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCacheImage(url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
}
