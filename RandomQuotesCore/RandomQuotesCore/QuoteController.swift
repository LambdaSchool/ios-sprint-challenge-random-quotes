//
//  QuoteController.swift
//  Random Quotes
//
//  Created by Ilgar Ilyasov on 12/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

public class QuoteController {
    
    // MARK: - Properties
    
    public var quotes = [Quote]()
    
    private let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=famous&count=1")!
    private let apiKey = "6rV8lFNtYomshU3DQuPFQ1tDYkaEp1Ja5ZFjsn3RJG1ROArk3n"
    
    // MARK: - Initializer
    
    public init() {}
    
    // MARK: - URL Session
    
    public func fetchQuotes(completion: @escaping (Error?) -> Void ) {
        
        var request = URLRequest(url: baseURL)
        request.addValue(apiKey, forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching quotes: \(error)")
                completion(error)
                return
            }
            
            if let response = response {
                NSLog("URL Session response: \(response)")
            }
            
            guard let data = data else {
                NSLog("No data returned: \(String(describing: error))")
                completion(error)
                return
            }
            
            do {
                let jsonArray = try JSONDecoder().decode([Quote].self, from: data)
                self.quotes = jsonArray
                completion(nil)
            } catch {
                NSLog("Error decoding json data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
}
