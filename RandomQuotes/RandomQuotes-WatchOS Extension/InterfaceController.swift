//
//  InterfaceController.swift
//  RandomQuotes-WatchOS Extension
//
//  Created by Nelson Gonzalez on 4/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    let quotesController = QuotesController()
    
    var quotes: Quote? {
        didSet {
            updateViews()
        }
    }
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    private func updateViews() {
        
        guard let quote = quotes else {return}
        DispatchQueue.main.async {
            self.quoteLabel.setText(quote.quote)
            self.authorLabel.setText("- \(quote.author)")
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func fetchSingleQuote() {
        
        quotesController.getQuotes { (quote, error) in
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
            }
            
            guard let quote = quote else {return}
            
            self.quotes = quote
            
        }
    }
    
    @IBAction func loadQuoteButtonPressed() {
        
        fetchSingleQuote()
    }
    
}
