//
//  QuotesController.swift
//  RandomQuotes
//
//  Created by Nelson Gonzalez on 4/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class QuotesController {
    
    private let baseUrl = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!
    private let apiKey = "f4Gbv51qWQmshRRneu7T312vs1Qwp164MuIjsnVfxaH9SgAOSP"

    private let urlSession: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        urlSession = URLSession(configuration: configuration)
    }
    
    func getQuotes(completion: @escaping(Quote?, Error?)-> Void) {
        
        var request = URLRequest(url: baseUrl)
        request.setValue(apiKey, forHTTPHeaderField: "X-Mashape-Key")
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error with the request: \(error)")
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil,nil)
                return
            }
            
            switch response.statusCode {
                
            case 200:
                if let data = data {
                    print("No data returned: \(String(describing: error))")
                    completion(nil, error)
                    do {
                        let decoder = JSONDecoder()
                        
                        let quotes = try decoder.decode([Quote].self, from: data).first
                        
                        completion(quotes, nil)
                        
                    } catch {
                        print("Error decoding data: \(error)")
                        completion(nil, error)
                    }
                }
                break
            default:
                completion(nil, error)
                break
            }
            
            }.resume()
        
    }
}
