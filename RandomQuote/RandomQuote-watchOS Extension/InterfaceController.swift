//
//  InterfaceController.swift
//  RandomQuote-watchOS Extension
//
//  Created by Scott Bennett on 12/10/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import WatchKit
import Foundation
import RandomQuoteCore

class InterfaceController: WKInterfaceController {
    
    // MARK: - Properties

    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    let fetcher = QuoteFetcher()
    
    private var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        fetchNewQuote()
    }
    
    @IBAction func fetchQuoteButton() {
        fetchNewQuote()
    }
    
    // MARK: - Private Functions
    
    private func fetchNewQuote() {
        fetcher.fetchQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quote: \(error)")
                return
            }
            self.quote = quote
        }
    }
    
    private func updateViews() {
        guard let quote = quote else { return }
        
        quoteLabel.setText(quote.quote)
        authorLabel.setText("- \(quote.author)")
    }
}
