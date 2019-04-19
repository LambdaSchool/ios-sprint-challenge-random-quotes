//
//  QuoteController.swift
//  RandomQuotes
//
//  Created by Nathanael Youngren on 4/19/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

enum URLFetchError: Error {
    case noData
    case unableToDecode
}

class QuoteController {
    
    func fetchQuote(completion: @escaping (Quote?, Error?) -> Void) {
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.addValue("andruxnet-random-famous-quotes.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        urlRequest.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                print("Error during URL session: \(error).")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error fetching data.")
                completion(nil, URLFetchError.noData)
                return
            }
            
            do {
                let quotesData = try JSONDecoder().decode([Quote].self, from: data)
                let quote = quotesData.first
                completion(quote, nil)
                return
            } catch {
                print("Error decoding data.")
                completion(nil, URLFetchError.unableToDecode)
                return
            }
        }
        
        task.resume()
    }
    
    let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.rapidapi.com")!
    let apiKey = "a691ed6153msh72a3f185a6e03a3p1ae313jsne7f5b30b3fe8"
}
