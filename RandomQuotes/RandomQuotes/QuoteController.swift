//
//  QuoteController.swift
//  RandomQuotes
//
//  Created by Farhan on 12/7/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import Foundation

class QuoteController {
    
    let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=famous")!
    let APIKey = "GYCv9WuqZbmshP2VO39uuCZH6rjAp1Ei6iujsnHWB5AlpNCCiS"
//    let quote = [Quote]
    
    func fetchRandomQuote(completion: @escaping (Quote?, Error?) -> Void) {
        
        var request = URLRequest(url: baseURL)
        request.setValue(APIKey, forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching Quote: \(error)")
                completion(nil, error)
            }
            
            guard let data = data else {
                return completion (nil, NSError())
            }
            
            do {
                let quote = try JSONDecoder().decode([Quote].self, from: data)
                completion(quote.first, nil)
            } catch {
                NSLog("Error decoding: \(error)")
                return completion(nil, error)
            }
        }.resume()
        
    }
    
}
