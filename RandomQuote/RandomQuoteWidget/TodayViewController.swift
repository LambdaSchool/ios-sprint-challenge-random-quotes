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
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
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
                self.quoteLabel.text = quote.quote
                self.authorLabel.text = "- \(quote.author)"
            }
            completionHandler(.newData)
        }
    }
    
    @IBAction func getNewQuote(_ sender: Any) {
        fetcher.fetchRandomQuote { (quote, error) in
            if let error = error {
                NSLog("\(error)")
                return
            }
            
            guard let quote = quote else {
                NSLog("No quote was fetched")
                return
            }
            
            DispatchQueue.main.async {
                self.quoteLabel.text = quote.quote
                self.authorLabel.text = "- \(quote.author)"
            }
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
            self.newQuoteButton.isHidden = true
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 200)
            self.newQuoteButton.isHidden = false
        }
    }
    
    let fetcher = QuoteFetcher()
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuoteButton: UIButton!
}
