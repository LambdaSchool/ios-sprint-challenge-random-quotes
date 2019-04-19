//
//  QuoteController.swift
//  RandomQuotes
//
//  Created by Julian A. Fordyce on 4/19/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation
import UIKit

class QuoteController {
    
    func getRandomQuote(_ randomQuote: String, completion: @escaping (Quote?, Error?) -> Void) {
        
        var request = URLRequest(url: baseURL)
        
        request.setValue(apiKey, forHTTPHeaderField: "X-Mashape-Key")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            
            if let error = error {
                NSLog("Error fetching quote: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            
            do {
                quote = try JSONDecoder().decode([Quote.self], from: data)
            } catch {
                NSLog("Error decoding Quote: \(error)")
            }
            
            completion(self.quote, nil)
            
            
        }.resume()





    }
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    // MARK: - Properties
    
    private let baseURL = URL(string: "https://andruxnet-random-famous-quotes.p.rapidapi.com/")!
    private let apiKey = "61294c2c10msh897c8dc53e129eep1399b9jsnf3153a2bbd0c"
    var quote: Quote?
}
