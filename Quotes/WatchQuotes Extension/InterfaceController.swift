//
//  InterfaceController.swift
//  WatchQuotes Extension
//
//  Created by Carolyn Lea on 10/26/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController
{

    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    let quoteController = QuoteController()
    var quote: Quote?
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
        
        quoteLabel.setText("")
        authorLabel.setText("")
        
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
    
    private func updateViews()
    {
        DispatchQueue.main.async {
            self.quoteLabel.setText(self.quote?.quote)
            self.authorLabel.setText(self.quote?.author)
        }
    }

}
