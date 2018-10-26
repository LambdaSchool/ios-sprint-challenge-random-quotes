//
//  InterfaceController.swift
//  Random Quotes Watch Extension
//
//  Created by Vuk Radosavljevic on 10/26/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    let quoteController = QuoteController()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        quoteController.fetchQuotes { (error) in
            guard error == nil else {return}
            DispatchQueue.main.async {
                let randomInt = Int(arc4random_uniform(UInt32(self.quoteController.quotes.count)))
                let quote = self.quoteController.quotes[randomInt]
                self.quoteController.quotes.remove(at: randomInt)
                self.quoteLabel.setText(quote.quote)
                self.authorLabel.setText(quote.author)
            }
        }
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        let randomInt = Int(arc4random_uniform(UInt32(self.quoteController.quotes.count)))
        if randomInt == 0 {
            return
        } else {
            let quote = self.quoteController.quotes[randomInt]
            self.quoteController.quotes.remove(at: randomInt)
            self.quoteLabel.setText(quote.quote)
            self.authorLabel.setText(quote.author)
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
