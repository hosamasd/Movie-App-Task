//
//  APIServices.swift
//  Movie App Task
//
//  Created by hosam on 8/18/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class APIServices: Codable {
    


let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"

func fetchVideos(completion: @escaping ([Video]) -> ()) {
    fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
}

func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
    fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
}

func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
    fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
}

func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
    let url = URL(string: urlString)
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
        if error != nil {
            print(error ?? "")
            return
        }
        
        do {
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let videos = try decoder.decode([Video].self, from: data)
            
            DispatchQueue.main.async {
                completion(videos)
            }
            
        } catch let jsonError {
            print(jsonError)
        }
        
        
        
        }.resume()
}

}
