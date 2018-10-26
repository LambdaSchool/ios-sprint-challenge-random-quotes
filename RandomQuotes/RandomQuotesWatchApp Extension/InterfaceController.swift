//
//  InterfaceController.swift
//  RandomQuotesWatchApp Extension
//
//  Created by Linh Bouniol on 10/26/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    // MARK: - Properties
    
    var quoteController = QuoteController()
    
    var quote: Quote? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets/Actions
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    @IBAction func refresh() {
        quoteController.fetchQuote { (quote, error) in
            if let error = error {
                NSLog("Error loading quote: \(error)")
            }
            
            guard let quote = quote else { return }
            
            self.quote = quote
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        refresh()
        updateViews()
    }
    
    func updateViews() {
        guard let quote = quote else { return }
        
        quoteLabel.setText("\(quote.quote)")
        authorLabel.setText("\(quote.author)")
    }

}
