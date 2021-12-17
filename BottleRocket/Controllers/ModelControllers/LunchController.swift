//
//  LunchController.swift
//  BottleRocket
//
//  Created by Ethan Perkins on 12/15/21.
//

import UIKit

class LunchController {
    
    static let baseURL = URL(string: "https://s3.amazonaws.com/br-codingexams/restaurants.json")
    static let cache = NSCache<NSString, UIImage>()
    
    static func fetchRestaurants(completion: @escaping (Result<[Restaurant], LunchError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        print(baseURL)
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let lunch = try JSONDecoder().decode(Lunch.self, from: data)
                let restaurants = lunch.restaurants
                
                return completion(.success(restaurants))
                
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    
    static func fetchRestaurantImage(restaurant: Restaurant, completion: @escaping (Result<UIImage, LunchError>) -> Void ) {
        
        let urlString = String(restaurant.backgroundImageURL)
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            print("using cached images")
            return completion(.success(image))
        }
        
        guard let imageURL = URL(string: urlString) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            self.cache.setObject(image, forKey: cacheKey)
            return completion(.success(image))
            
        }.resume()
    }
}
