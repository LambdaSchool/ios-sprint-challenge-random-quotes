//
//  QuoteController.swift
//  RandomQuote
//
//  Created by Simon Elhoej Steinmejer on 26/10/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation

public class QuoteController
{
    public static let shared = QuoteController()
    
    let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!
    
    public func fetchQuote(completion: @escaping (Quote?, Error?) -> ())
    {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("AgX0Rt6kJ8msh2UhtLn9X4n9Isf2p1RTnJdjsnjbZmD4QHXTUq", forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error
            {
                NSLog("Error fetching quote: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error unwrapping data: \(NSError())")
                completion(nil, NSError())
                return
            }
            
            do {
                
                let quote = try JSONDecoder().decode([Quote].self, from: data)
                completion(quote.first, nil)
                
            } catch let error {
                NSLog("Error decoding data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
}
