//
//  InterfaceController.swift
//  RandomQuotesWatch Extension
//
//  Created by De MicheliStefano on 26.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import WatchKit
import Foundation
import RandomQuoteCore

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    
    let randomQuoteClient = RandomQuoteClient()
    var randomQuote: Quote? {
        didSet {
            updateViews()
        }
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        randomQuoteClient.fetchRandomQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quotes: \(error)")
                return
            }
            
            guard let quote = quote else { return }
            
            DispatchQueue.main.async {
                self.randomQuote = quote
            }
        }
    }
    
    private func updateViews() {
        quoteLabel?.setText("\"\(randomQuote?.quote ?? "")\"")
        authorLabel?.setText("- \(randomQuote?.author ?? "")")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
