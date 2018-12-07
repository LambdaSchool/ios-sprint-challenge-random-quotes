//
//  QuoteFetcher.swift
//  Random Quote-Core
//
//  Created by Scott Bennett on 12/7/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

public class QuoteFetcher {
    
    public struct Quote: Decodable {
        public let quote: String
        public let author: String
        public let category: String
    }
    
    public init() {}
    
    private let baseURL = "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=famous&count=10/"
    private let headers = ["X-Mashape-Key": "dJuunwHKQbmsh7kmyys4SRF7gQhop1cBiFrjsnoHckXSaw6pGi","Accept": "application/json"]
    
    public func fetchQuote() {
        
        let urlComponents = URLComponents(string: baseURL)
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        guard let url = URL(string: baseURL) else { return }

        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with URL: \(error)")
            }
            
            guard let data = data else { return }
            
            do {
                let quote = try JSONDecoder().decode(Quote.self, from: data)
                print(quote.quote)
            } catch let error {
                NSLog("Error serializing JSON: \(error)")
            }
            
        }.resume()
        
    }
}



