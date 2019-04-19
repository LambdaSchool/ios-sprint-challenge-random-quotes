//
//  InterfaceController.swift
//  RandomQuotes-watchOS Extension
//
//  Created by Lambda_School_Loaner_34 on 4/19/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import WatchKit
import Foundation
import RandomQuotesCore_watchOS



class InterfaceController: WKInterfaceController {
    
    //MARK: - Properties
    var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    private let quoteController = QuoteController()
    
    
    //MARK: - Outlets
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        quoteController.fetchRandomQuote { (quote, error) in
            
            if let error = error {
                NSLog("Found error trying to retrieve quote: \(error)")
                return
            }
            
            self.quote = quote
        }
    }
    
    private func updateViews() {
        guard let quote = quote else { return }
        
        let quoteString = "\"\(quote.quote)\""
        let authorString = "- \(quote.author)"
        
        quoteLabel.setText(quoteString)
        authorLabel.setText(authorString)
    }
}
