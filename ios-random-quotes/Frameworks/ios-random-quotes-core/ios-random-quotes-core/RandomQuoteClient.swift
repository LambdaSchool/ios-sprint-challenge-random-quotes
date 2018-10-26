//
//  RandomQuoteClient.swift
//  RandomQuotesCore
//
//  Created by De MicheliStefano on 26.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

public class RandomQuoteClient {
    
    public init() {}
    
    // MARK: - Properties
    private let baseUrlString = "https://andruxnet-random-famous-quotes.p.mashape.com/"
    private let apiKey = ""
    
    // MARK: - Public
    public func fetchRandomQuote(completion: @escaping (Quote?, Error?) -> Void) {
        let url = URL(string: baseUrlString)!
//        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
//        let countQueryItem = URLQueryItem(name: "count", value: "1")
//        components?.queryItems = [countQueryItem]
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error receiving data")
                completion(nil, NSError())
                return
            }
            
            do {
                let decodedQuotes = try JSONDecoder().decode([Quote].self, from: data)
                if let quote = decodedQuotes.first {
                    completion(quote, nil)
                }
            } catch {
                NSLog("Error decoding data \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    
    // MARK: - Private
    
}
