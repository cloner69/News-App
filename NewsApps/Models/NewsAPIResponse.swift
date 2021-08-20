//
//  NewsAPIResponse.swift
//  NewsAPIResponse
//
//  Created by Adrian Suryo Abiyoga on 20/08/21.
//

import Foundation

struct NewsAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
}
