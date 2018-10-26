//
//  QuoteControlller.swift
//  RandomQuotes
//
//  Created by Linh Bouniol on 10/26/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

class QuoteController {
    
    static let baseURL = URL(string: "https://andruxneX-Mashape-Keyt-random-famous-quotes.p.mashape.com/")!
    static let apiKey = "Xpm4NyR90JmsheFbs8RkBlEUhfOlp17X8LxjsnSU87EcxXEGqM"
    
    func fetchQuote(completion: @escaping (Quote?, Error?) -> Void) {
        
        let url = QuoteController.baseURL
        
        var request = URLRequest(url: url)
        request.setValue(QuoteController.apiKey, forHTTPHeaderField: "X-Mashape-Key")
        
        // don't need httpMethod, it is automatically "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching quote: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            do {
                let quote = try JSONDecoder().decode(Quote.self, from: data)
                DispatchQueue.main.async {
                    completion(quote, nil)
                }
            } catch {
                NSLog("Unable to decode quote: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
        
    }
}
