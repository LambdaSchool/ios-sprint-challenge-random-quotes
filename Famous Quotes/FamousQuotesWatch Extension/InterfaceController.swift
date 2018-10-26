//
//  InterfaceController.swift
//  FamousQuotesWatch Extension
//
//  Created by Andrew Dhan on 10/26/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        quoteLabel.setText("\"I'd like a chicken fried steak with extra chicken\"")
        authorLabel.setText("-Anonymous")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        quoteController.fetchQuotes { (quote, error) in
            if let error = error {
                NSLog("Error fetching quotes: \(error)")
            }
            guard let quote = quote else {return}
            DispatchQueue.main.async {
                self.quoteLabel.setText("\"\(quote.quote)\"")
                self.authorLabel.setText("- \(quote.author)")
            }
        }
        
        
    }
    //MARK: - Properties
    let quoteController = QuoteController()
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
}
