//
//  ViewController.swift
//  ios-random-quote
//
//  Created by Conner on 10/26/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit
import QuoteCore

class QuoteViewController: UIViewController {
    // MARK: - Properties
    let quoteController = QuoteController()

    // MARK: - IBOutlets
    @IBOutlet var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteController.getQuote { (quote, error) in
            if let error = error {
                NSLog("No quote, error: \(error)")
                return
            }
            
            guard let quote = quote else { return }
            
            DispatchQueue.main.async {
                self.quoteLabel.text = "\(quote.quote) - \(quote.author)"
            }
        }
    }
}

