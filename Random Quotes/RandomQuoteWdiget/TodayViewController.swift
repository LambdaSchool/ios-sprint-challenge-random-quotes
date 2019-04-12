//
//  TodayViewController.swift
//  RandomQuoteWdiget
//
//  Created by Moses Robinson on 4/12/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit
import NotificationCenter
import RandomQuotesCore

class TodayViewController: UIViewController, NCWidgetProviding {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        quoteController.fetchRandomQuote { (quote, error) in
            
            if let error = error {
                NSLog("Found error trying to retrieve quote: \(error)")
                return
            }
            
            self.quote = quote
        }
        completionHandler(NCUpdateResult.newData)
    }
    
    private func updateViews() {
        
        guard let quote = quote, isViewLoaded else { return }
        
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
    }
    
    // MARK: - Properties
    
    var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    let quoteController = QuoteController()
    
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
}
