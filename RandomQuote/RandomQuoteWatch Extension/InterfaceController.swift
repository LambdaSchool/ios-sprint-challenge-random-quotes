//
//  InterfaceController.swift
//  RandomQuoteWatch Extension
//
//  Created by Simon Elhoej Steinmejer on 26/10/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import WatchKit
import Foundation
import QuoteCore_Watch

class InterfaceController: WKInterfaceController
{
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
        fetchNewQuote()
    }
    
    private func fetchNewQuote()
    {
        QuoteController.shared.fetchQuote { (quote, error) in
            
            if let error = error
            {
                NSLog("Error fetching quote: \(error)")
                return
            }
            
            guard let quote = quote else {
                NSLog("Failed to unwrap quote")
                return
            }
            
            DispatchQueue.main.async {
                self.authorLabel.setText("- \(quote.author)")
                self.quoteLabel.setText("\"\(quote.quote)\"")
            }
        }
    }
    
    @IBAction func handleRefresh()
    {
        fetchNewQuote()
    }
}
