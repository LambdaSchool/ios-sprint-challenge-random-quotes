//
//  QuoteFetcher.swift
//  RandomQuote
//
//  Created by Scott Bennett on 12/9/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

public class QuoteFetcher {
    
    // MARK: - Properties
    let qoutes = [Quote]()
    
    public init() {}
    
    private let baseURL = "https://andruxnet-random-famous-quotes.p.mashape.com/"
    private let apiKey = "dJuunwHKQbmsh7kmyys4SRF7gQhop1cBiFrjsnoHckXSaw6pGi"
    
    
    // Fetch a quote from the API
    public func fetchQuote(completion: @escaping (Quote?, Error?) -> Void) {
        
        // Build url with header field
        var url = URLRequest(url: URL(string: baseURL)!)
        url.setValue(apiKey, forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data")
                completion(nil, error)
                return }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                let quote = quotes.first
                completion(quote, nil)
                
            } catch let error {
                NSLog("Error serializing JSON: \(error)")
                completion(nil, error)
                return
            }
            
            }.resume()
        
    }
}
