//
//  ViewController.swift
//  Quotes
//
//  Created by Carolyn Lea on 10/26/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let quoteController = QuoteController()
        quoteController.fetchQuote { (quote, error) in
            if let error = error
            {
                NSLog("Error fetching quotes from network: \(error)")
                return
            }
            print("\(String(describing: quote))")
        }
    }


}

