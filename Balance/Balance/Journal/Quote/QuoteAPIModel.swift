//
//  QuoteAPI.swift
//  Balance
//
//  Created by Yanika Telus on 10/27/23.
//
//tutorial https://www.youtube.com/watch?v=ERr0GXqILgc&ab_channel=SeanAllen

import Foundation

struct QuoteModel: Codable {
    var _id: String
    var content: String
    var author: String
    var length: Double
    var tags: [String]
}

class QuoteAPIModel {
    func getQuote() async throws -> QuoteModel {
    ///async and throws- Leverages Swift's concurrency features and error handling capabilities. async makes it easier to use in asynchronous contexts, and throws allows it to propagate errors that can be handled by the caller

        guard let quotableURL  = URL(string: "https://api.quotable.io/random") else {
            print("Failed to load URL")
            throw URLError(.badURL)
        }
        //removed response
        let (data, _) = try await URLSession.shared.data(from: quotableURL)
        
        let jsonData = try JSONDecoder().decode(QuoteModel.self, from: data)

        return jsonData
    }
}
