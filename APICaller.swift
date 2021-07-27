//
//  APICaller.swift
//  NewsAPI
//
//  Created by Adrian Suryo Abiyoga on 27/07/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2021-06-27&sortBy=publishedAt&apiKey=7b0d82cec75d4620b4108327484b9e3a")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Articles], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

// Models

struct APIResponse: Codable {
    let articles: [Articles]
}

struct Articles: Codable {
    let Source : Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}