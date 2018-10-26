//
//  InterfaceController.swift
//  ios-sprint14-watch Extension
//
//  Created by David Doswell on 10/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    var quote: Quote?
    var quoteController: QuoteController?

    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let quote = quote else { return }
        
        quoteController?.fetchQuote(with: quote, completion: { (error) in
            if let error = error {
                NSLog("Error fethcing quote: \(error)")
            }
            self.quoteLabel.setText(quote)
        })
        
    }

}
