//
//  QuoteController.swift
//  Random Quotes
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

public class QuoteController {
    
    public func fetchSingleQuote() {
        var request = URLRequest(url: baseURL)
        request.addValue("dZ5pJldpLRmsh74FcLkkjAvtFm8Zp1bYMTnjsn1MKkJ9uxxDpF", forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with datatask: \(error)")
                return
            }
            guard let data = data else { return }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                self.quote = quotes.first!
            } catch {
                NSLog("Error decoding JSON data")
            }
        }.resume()
    }
    
    public var quote: Quote?
    
    // AMRK: - Private
    
    private let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!
}
