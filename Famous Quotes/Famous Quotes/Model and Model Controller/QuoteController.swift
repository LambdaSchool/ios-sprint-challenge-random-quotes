//
//  QuoteController.swift
//  Famous Quotes
//
//  Created by Andrew Dhan on 10/26/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation
private let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=famous&count=1")!

class QuoteController{
    
    //MARK: - CRUD
    func add(quote: String, author: String, category: String = "Famous"){
        let newQuote = Quote(quote: quote, author: author, category: category)
        quotes.append(newQuote)
    }
    
    //MARK: - Networking
    
    func fetchQuotes(completion: @escaping (Quote?,Error?) -> Void){
        let headers = ["X-Mashape-Key": "RWjrU3jaLmmshkP4WVtwATgS1H1np1hMh6Ujsn9ZkJbkTwl4ki", "Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]
        var request = URLRequest(url: baseURL)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("Data is nil")
                return
            }
            do{
                let quote = try JSONDecoder().decode([Quote].self, from: data)
                completion(quote.first,nil)
                return
            }catch {
                completion(nil,error)
                return
            }
        }.resume()
    }
    //MARK: - Properties
    var quotes = [Quote]()
}

