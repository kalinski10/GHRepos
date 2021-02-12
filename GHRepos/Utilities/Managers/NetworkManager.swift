//
//  NetworkManager.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit


final class NetworkManager {
    static let shared   = NetworkManager()
    let baseUrl         = "https://api.github.com/search/repositories"
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getRepos(search: String, page: Int, completed: @escaping (Result<[Repo], GRError>) -> Void) {
        
        let endPoint = baseUrl + "?q=\(search)&per_page=20&page=\(page)"
        
        guard let url = URL(string: endPoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let search = try decoder.decode(Search.self, from: data)
                completed(.success(search.items))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self      = self,  // single guard statement, if any of these go wrong pass completed nil instead of doing check on every single one
                error           == nil,
                let response    = response as? HTTPURLResponse, response.statusCode == 200,
                let data        = data,
                let image       = UIImage(data: data)
            else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
    
}
