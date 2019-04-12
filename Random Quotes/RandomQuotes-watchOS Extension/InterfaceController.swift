//
//  InterfaceController.swift
//  RandomQuotes-watchOS Extension
//
//  Created by Moses Robinson on 4/12/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import WatchKit
import Foundation
import RandomQuotesCore_watchOS

class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        quoteController.fetchRandomQuote { (quote, error) in
            
            if let error = error {
                NSLog("Found error trying to retrieve quote: \(error)")
                return
            }
            
            self.quote = quote
        }
    }
    
    private func updateViews() {
        
        guard let quote = quote else { return }
        
        let quoteString = "\"\(quote.quote)\""
        let authorString = "- \(quote.author)"
        
        quoteLabel.setText(quoteString)
        authorLabel.setText(authorString)
    }
    
    //MARK: - Properties
    
    var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    private let quoteController = QuoteController()
    
    @IBOutlet var quoteLabel: WKInterfaceLabel!
    @IBOutlet var authorLabel: WKInterfaceLabel!
}
