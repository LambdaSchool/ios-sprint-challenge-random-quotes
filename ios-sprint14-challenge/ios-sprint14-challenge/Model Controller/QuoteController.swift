//
//  QuoteController.swift
//  ios-sprint14-challenge
//
//  Created by David Doswell on 10/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

public class QuoteController {
    
    private(set) var quotes: [Quote] = []
    
    private let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!
    
    enum Method: String {
        case get
    }
    
    func createQuote(with text: String) {
        let quote = Quote(text: text)
        quotes.append(quote)
    }
    
    func fetchQuote(with quote: Quote, completion: @escaping (Error?) -> Void) {
        
        let url = baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = Method.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching request: \(error)")
                completion(error)
                return
            }
            guard let data = data else { completion(NSError()); return }
            
            do {
                let quotes = try JSONDecoder().decode([String:Quote].self, from: data)
                let quote = quotes.map({$0.value})
                self.quotes = quote
            } catch {
                NSLog("Error fetching data: \(error)")
            }
        }
    }
        
}
