//
//  QuoteController.swift
//  ios-random-quote
//
//  Created by Conner on 10/26/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

public class QuoteController {

    // MARK: - Properties
    let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!

    // MARK: - Public Functions
    public func getQuote(completion: @escaping (Quote?, Error?) -> Void) {
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.setValue("AONmdmL3Uqmsh7N4Kp2nnt0NlGqcp19BXSajsnn9ONaKJVeSiw", forHTTPHeaderField: "X-Mashape-Key")

        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching quote: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else { return }

            do {
                let jsonDecoder = JSONDecoder()
                let quote = try jsonDecoder.decode(Quotes.self, from: data).first
                completion(quote, nil)
            } catch {
                NSLog("Error trying to decode JSON")
            }
        }.resume()
    }
}
