//
//  AppDelegate.swift
//  Random Quote
//
//  Created by Samantha Gatt on 10/26/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let quoteController = QuoteController()
        quoteController.fetchQuote { (quote, error) in
            if let error = error {
                NSLog("Error with fetch: \(error)")
                return
            }
            
            guard let quote = quote else {
                NSLog("Quote was nil")
                return
            }
            
            NSLog("\"\(quote.quote)\" -\(quote.author)")
        }
        
        return true
    }

}

