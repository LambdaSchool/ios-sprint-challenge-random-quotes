//
//  Quote.swift
//  Random Quote
//
//  Created by Samantha Gatt on 10/26/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

struct Quote: Decodable {
    var quote: String
    var author: String
}

class QuoteController {
    
    static let url = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/?count=1")!
    static let apiKey = "M6hNpOsGrGmshbZ8nzvPlPwkNO12p1bpAvJjsnYjVcf0DgeXIB"
    
    func fetchQuote(completion: @escaping (Quote?, Error?) -> Void) {
        
        var request = URLRequest(url: QuoteController.url)
        request.allHTTPHeaderFields = ["X-Mashape-Key": QuoteController.apiKey,
                                       "Content-Type": "application/x-www-form-urlencoded",
                                       "Accept": "application/json"]
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching random quote: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let quote = try JSONDecoder().decode([Quote].self, from: data).first
                completion(quote, nil)
            } catch {
                completion(nil, error)
                return
            }
            }.resume()
    }
    
}
