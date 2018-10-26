//
//  QuoteController.swift
//  Quotes
//
//  Created by Carolyn Lea on 10/26/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

class QuoteController
{
    static let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/?count=1")!
    static let apiKey = "4rlCjLYnXvmshc7Run8UAaU8GqJ3p1dk94UjsnCDGUDQaQx7pX"
    
    func fetchQuote(completion: @escaping (Quote?, Error?) -> Void)
    {
        var request = URLRequest(url: QuoteController.baseURL)
        request.allHTTPHeaderFields = ["X-Mashape-Key": QuoteController.apiKey,
                                       "Content-Type": "application/x-www-form-urlencoded",
                                       "Accept": "application/json"]
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error
            {
                NSLog("Error fetching data \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog(" Error fetching data. No data returned.")
                completion(nil, NSError())
                return
            }
            
            do
            {
                
                let jsonDecoder = JSONDecoder()
                let quote = try jsonDecoder.decode([Quote].self, from: data).first
                
                completion(quote, nil)
            }
            catch
            {
                NSLog("Unable to decode data into quote: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
}
