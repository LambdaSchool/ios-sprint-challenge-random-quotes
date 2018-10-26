//
//  InterfaceController.swift
//  RandomQuotesWatch Extension
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        updateViews()
    }
    
    private func updateViews() {
        quoteController.fetchSingleQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quote in viewController: \(error)")
                return
            }
            guard let quote = quote else { return }
            self.quote = quote
        }
    }
    
    let quoteController = QuoteController()
    var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                if let quote = self.quote {
                    self.quoteLabel.setText("\"\(quote.quote)\"")
                    self.authorLabel.setText("- \(quote.author)")
                }
            }
        }
    }
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
}
