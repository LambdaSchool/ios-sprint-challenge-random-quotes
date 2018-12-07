//
//  InterfaceController.swift
//  RandomQuote-watchOS Extension
//
//  Created by Daniela Parra on 12/7/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import WatchKit
import Foundation
import RandomQuoteCore

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        fetchNewQuote()
    }
    
    @IBAction func getNewQuote() {
        fetchNewQuote()
    }
    
    private func updateViews() {
        guard let quote = quote else { return }
        
        quoteLabel.setText(quote.quote)
        authorLabel.setText("- \(quote.author)")
    }
    
    private func fetchNewQuote() {
        fetcher.fetchRandomQuote { (quote, error) in
            if let error = error {
                NSLog("\(error)")
                return
            }
            
            self.quote = quote
        }
    }
    
    let fetcher = QuoteFetcher()
    var quote: RandomQuote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
}
