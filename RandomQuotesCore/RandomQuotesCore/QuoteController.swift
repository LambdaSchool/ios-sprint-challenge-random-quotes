//
//  QuoteController.swift
//  RandomQuotesCore
//
//  Created by Lambda_School_Loaner_34 on 4/19/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//
import Foundation

public class QuoteController {
    
    //MARK: - Properties
    private let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.rapidapi.com/")!
    private let apiKey = "bd5df6068fmsha3443ca4e65cd08p12f5a1jsn8fbe63cd285d"
    
    public init() {}
    
    public func fetchRandomQuote(completion: @escaping (Quote?, Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "cat", value: "movies")]
        
        let url = urlComponents?.url
        var request = URLRequest(url: url!)
        
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error grabbing quote: \(error)")
                completion(nil, NSError())
                return
            }
            
            guard let data = data else {
                NSLog("No quote data found")
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let quoteArray = try jsonDecoder.decode([Quote].self, from: data)
                let quote = quoteArray.first
                completion(quote, nil)
            } catch {
                NSLog("Could no decode quote")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
}
