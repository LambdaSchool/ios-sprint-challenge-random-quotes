//
//  InterfaceController.swift
//  RandomQuotes-watchOS Extension
//
//  Created by Nathanael Youngren on 4/19/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        quoteController.fetchQuote { (quote, error) in
            if let error = error {
                print("Error running fetchQuote method: \(error).")
                return
            }
            self.quote = quote
        }
    }
    
    func updateViews() {
        if let quote = quote {
            let quoteString = "\"" + quote.quote + "\""
            quoteLabel.setText(quoteString)
            let authorString = "- " + quote.author
            authorLabel.setText(authorString)
        }
    }
    
    var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    let quoteController = QuoteController()
}
