//
//  TodayViewController.swift
//  RandomQuoteWidget
//
//  Created by Scott Bennett on 12/10/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit
import NotificationCenter
import RandomQuoteCore

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: - Properties
        
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    private let fetcher = QuoteFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        fetcher.fetchQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quote: \(error)")
                completionHandler(NCUpdateResult.failed)
                return
            }
            
            guard let quote = quote else {
                completionHandler(.noData)
                return
            }
            
            DispatchQueue.main.async {
                self.quoteLabel.text = quote.quote
                self.authorLabel.text = "- \(quote.author)"
            }
            completionHandler(.newData)
        }
   
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
