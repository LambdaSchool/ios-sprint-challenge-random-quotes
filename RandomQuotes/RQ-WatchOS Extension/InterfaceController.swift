//
//  InterfaceController.swift
//  RQ-WatchOS Extension
//
//  Created by Farhan on 12/7/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    var quote: Quote?{
        didSet{
            DispatchQueue.main.async {
                self.updateLabel()
            }
        }
    }
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        newQuote()
    }
    
    @IBAction func newQuote() {
        let qc = QuoteController()
        qc.fetchRandomQuote { (quote, _) in
            self.quote = quote
        }
    }
    
    private func updateLabel(){
        guard let quote = quote else {return}
        quoteLabel.setText(quote.quote + " - " + quote.author)
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
