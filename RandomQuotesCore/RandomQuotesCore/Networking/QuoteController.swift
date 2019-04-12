//
//  QuoteController.swift
//  RandomQuotesCore
//
//  Created by Moses Robinson on 4/12/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

public class QuoteController {
    
    public init() {}
    
    public func fetchRandomQuote(completion: @escaping (Quote?, Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = [URLQueryItem(name: "cat", value: "famous")]
        
        let url = urlComponents?.url
        
        var request = URLRequest(url: url!)
        
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error grabbing quote: \(error)")
                completion(nil, NSError())
                return
            }
            
            guard let data = data else {
                NSLog("No quote data found")
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let quoteDictionary = try jsonDecoder.decode([String : Quote].self, from: data)
                
                let quote = quoteDictionary.first?.value
                
                completion(quote, nil)
            } catch {
                NSLog("Could no decode quote")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
    
    private let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.rapidapi.com/")!
    
    private let apiKey = "55d1a9ccc2msh0bdf182300ce3d1p1e40c3jsn514cc1823b7f"
}
