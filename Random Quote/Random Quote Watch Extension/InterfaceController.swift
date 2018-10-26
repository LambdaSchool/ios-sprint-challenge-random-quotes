//
//  InterfaceController.swift
//  Random Quote Watch Extension
//
//  Created by Samantha Gatt on 10/26/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        quoteLabel.setText("")
        authorLabel.setText("")
        newQuoteButton.setEnabled(false)
        
        fetchAQuote()
    }
    
    
    // MARK: - Private Properties
    
    let quoteController = QuoteController()
    var quote: Quote?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    @IBOutlet weak var newQuoteButton: WKInterfaceButton!
    
    
    // MARK: - Private Functions
    
    private func updateViews() {
        DispatchQueue.main.async {
            self.quoteLabel.setText("\"\(self.quote?.quote ?? "Oops, looks like there was an error fetching your random quote")\"")
            self.authorLabel.setText("- \(self.quote?.author ?? "- Random Quote Staff")")
            self.newQuoteButton.setEnabled(true)
        }
    }
    
    private func fetchAQuote() {
        
        self.newQuoteButton.setEnabled(false)
        
        quoteController.fetchQuote { (quote, error) in
            
            if let error = error {
                NSLog("Error with fetch: \(error)")
                return
            }
            
            guard let quote = quote else {
                NSLog("Quote was nil")
                return
            }
            
            self.quote = quote
            
            self.updateViews()
        }
    }
    
    
    // MARK: - Actions
    
    
    @IBAction func fetchNewQuote() {
        fetchAQuote()
    }
}
