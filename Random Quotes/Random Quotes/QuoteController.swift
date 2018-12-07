//
//  QuoteController.swift
//  Random Quotes
//
//  Created by Moin Uddin on 12/7/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation


class QuoteController {
    
    static let shared = QuoteController()
    
    
    func getQuote(completion: @escaping (Quote?, Error?) -> Void) {
        var request = URLRequest(url: baseUrl)
        request.setValue(apiKey, forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Theere was an error getting the quote: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let quote = try JSONDecoder().decode([Quote].self, from: data).first
                completion(quote, nil)
            } catch {
                NSLog("Error decoding JSON")
                return
            }
        }.resume()
    }
    
    let apiKey = "Zn6GslkyY9mshlvCHYSrczsmBUnSp1a5FqijsnbRDlvYCO175m"
    let baseUrl = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!
}
