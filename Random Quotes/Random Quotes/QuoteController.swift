//
//  QuoteController.swift
//  Random Quotes
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

public class QuoteController {
    
    public func fetchSingleQuote(completion: @escaping (Quote?, Error?) -> Void) {
        var request = URLRequest(url: baseURL)
        request.addValue("dZ5pJldpLRmsh74FcLkkjAvtFm8Zp1bYMTnjsn1MKkJ9uxxDpF", forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with datatask: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                let quote = quotes.first!
                completion(quote, nil)
                return
            } catch {
                NSLog("Error decoding JSON data")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    public var quote: Quote?
    
    // AMRK: - Private
    
    private let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!
}
