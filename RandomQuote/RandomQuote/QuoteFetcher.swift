//
//  QuoteFetcher.swift
//  RandomQuote
//
//  Created by Daniela Parra on 12/7/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

class QuoteFetcher {
    
    func fetchRandomQuote(completion: @escaping (RandomQuote?, Error?) -> Void) {
        
        let request = NSMutableURLRequest(url: baseURL)
        request.addValue("cQnc1jam7ymshjUWLhUStwXNeCP4p1vbHPYjsnVcKZuLfb52EE", forHTTPHeaderField: "X-Mashape-Key")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching random quote: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data received from data task")
                completion(nil, NSError())
                return
            }
            
            if let json = String(data: data, encoding: .utf8) {
                print(json)
            }
            
            do {
                let quoteResults = try JSONDecoder().decode([RandomQuote].self, from: data)
                let quote = quoteResults.first
                completion(quote, nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(nil, error)
                return
            }
            
            
        }.resume()
        
    }
    
    private let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!
    private let APIKey = ""
}
