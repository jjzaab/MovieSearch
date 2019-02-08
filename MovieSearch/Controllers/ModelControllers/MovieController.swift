//
//  MovieController.swift
//  MovieSearch
//
//  Created by XMS_JZhan on 2/8/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import UIKit

class MovieController {
    
    // Constants
    static let baseURL = URL(string: "https://api.themoviedb.org/3")
    static let apiKey = "5c30b2e87921f2e633bf977130ecb0f2"
    
    // MARK: - Fetch Movie List from search term request
    static func fetchRequestFor(searchTerm: String, completion: @escaping (([Movie]) -> Void )) {
    
        guard var url = baseURL else {
            print("Error unwrapping URL")
            completion([])
            return
        }
        url.appendPathComponent("search")
        url.appendPathComponent("movie")
        
        let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
        let searchQuery = URLQueryItem(name: "query", value: searchTerm)
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [apiKeyQuery, searchQuery]
        
        guard let finalURL = urlComponents?.url else { completion([]); return }
        
        print(finalURL.absoluteString)
        
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error) \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("Error getting data")
                completion([])
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let topLevel = try jsonDecoder.decode(TopLevelJSON.self, from: data)
                completion(topLevel.results)
            } catch {
                print("Error decoding JSON: \(error) \(error.localizedDescription)")
                completion([])
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Fetch Image for each movie request
    static func fetchImageFor(jpegURL: String, completion: @escaping ((UIImage?) -> Void )) {
        
        // URL for fetching images
        let imageURL = URL(string: "https://image.tmdb.org")
        
        guard var url = imageURL else {
            print("URL")
            completion(nil)
            return
        }
        url.appendPathComponent("t")
        url.appendPathComponent("p")
        url.appendPathComponent("w200")
        url.appendPathComponent(jpegURL)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error getting data")
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Error creating image")
                completion(nil)
                return
            }
            completion(image)
        }
        dataTask.resume()
    }
}
