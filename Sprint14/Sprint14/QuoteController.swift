//
//  QuoteController.swift
//  Sprint14
//
//  Created by Vuk Radosavljevic on 10/26/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class QuoteController {

    var quotes = [Quote]() {
        didSet {
            print(quotes)
        }
    }
    
    let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!
    let apiKey = "9obWvAEVhNmshqwT37KwLIpMrFMgp1P8w54jsnRUryYcEwx8GE"
    
    func fetchQuotes(completion: @escaping (Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let catItem = URLQueryItem(name: "cat", value: "famous")
        let countItem = URLQueryItem(name: "count", value: "10")
        
        components.queryItems = [catItem, countItem]
        
        var request = URLRequest(url: components.url!)
        request.addValue(apiKey, forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("error fetching data \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("error getting data")
                completion(NSError())
                return
            }
            
            
            do {
                let jsonDecoder = JSONDecoder()
                let fetchedQuotes = try jsonDecoder.decode([Quote].self, from: data)
                self.quotes = fetchedQuotes
                completion(nil)
                return
            } catch {
                completion(error)
                return
            }
        }.resume()
    }
}
