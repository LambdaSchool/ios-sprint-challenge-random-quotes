//
//  TodayViewController.swift
//  RandomQuoteWidget
//
//  Created by Daniela Parra on 12/7/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit
import NotificationCenter
import RandomQuoteCore

class TodayViewController: UIViewController, NCWidgetProviding {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        fetcher.fetchRandomQuote { (quote, error) in
            if let error = error {
                NSLog("\(error)")
                completionHandler(.failed)
                return
            }
            
            guard let quote = quote else {
                NSLog("No quote was fetched")
                completionHandler(.noData)
                return
            }
            
            DispatchQueue.main.async {
                self.quoteTextView.text = quote.quote
                self.authorLabel.text = "- \(quote.author)"
            }
            completionHandler(.newData)
        }
    }
    
    let fetcher = QuoteFetcher()
    
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
}
