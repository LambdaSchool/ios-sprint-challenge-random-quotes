//
//  InterfaceController.swift
//  Quote-watchOS Extension
//
//  Created by Moin Uddin on 12/7/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        QuoteController.shared.getQuote { (quote, error) in
            if let error = error {
                NSLog("Error getting Quote on Watch: \(error)")
                return
            }
            
            guard let quote = quote else { return }
            
            DispatchQueue.main.async {
                self.updateViews(quote)
            }
        }
    }
    
    func updateViews(_ quote: Quote) {
        self.quoteLabel.setText(" \"\(quote.quote)\"  ")
        self.authorLabel.setText(" - \(quote.author)")
    }
    
    override func willActivate() {
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
}
