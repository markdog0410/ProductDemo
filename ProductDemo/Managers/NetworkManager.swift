//
//  NetworkManager.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/16.
//

import UIKit

class NetworkManager {

    static let share = NetworkManager()
    let prodcutBaseUrl = "https://fakestoreapi.com/products/"
    let cache = NSCache<NSString, NSArray>()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getCategories() async throws -> [String] {
        let cacheKey = "categories" as NSString
                
        // 尝试从缓存中获取数据
        if let cachedCategories = cache.object(forKey: cacheKey) as? [String] {
            return cachedCategories
        }
        
        var urlComponents = URLComponents(string: prodcutBaseUrl)
            urlComponents?.path += "categories"
        
        guard let url = urlComponents?.url else {
            throw ErrorCase.unableGetCategories
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
            
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ErrorCase.invalidResponse
        }
        
        do {
            let categories = try decoder.decode([String].self, from: data)
            cache.setObject(categories as NSArray, forKey: cacheKey)
            return categories
        } catch {
            print("invalid categories data")
            throw ErrorCase.invalidData
        }
    }
    
    func getInCategory(category: String) async throws -> [CategoryElement] {
        var urlComponents = URLComponents(string: prodcutBaseUrl)
            urlComponents?.path += "category/\(category)"
        
        guard let url = urlComponents?.url else {
            throw ErrorCase.unableGetCategories
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
            
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ErrorCase.invalidResponse
        }
        
        do {
            let categoryProducts = try decoder.decode([CategoryElement].self, from: data)            
            return categoryProducts
        } catch {
            print("invalid categories data")
            throw ErrorCase.invalidData
        }
    }
}
