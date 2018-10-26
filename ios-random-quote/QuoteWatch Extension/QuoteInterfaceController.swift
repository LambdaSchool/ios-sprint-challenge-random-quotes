//
//  InterfaceController.swift
//  QuoteWatch Extension
//
//  Created by Conner on 10/26/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import WatchKit
import Foundation
import QuoteCoreWatch

class QuoteInterfaceController: WKInterfaceController {
    
    // MARK: - Properties
    let quoteController = QuoteController()

    // MARK: - IBOutlets
    @IBOutlet var quoteLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        quoteController.getQuote { (quote, error) in
            if let error = error {
                NSLog("No quote: \(error)")
                return
            }
            
            guard let quote = quote else { return }
            
            DispatchQueue.main.async {
                self.quoteLabel.setText("\(quote.quote) - \(quote.author)")
            }
        }
    }
}
