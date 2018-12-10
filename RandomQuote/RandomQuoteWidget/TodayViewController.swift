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
    @IBOutlet weak var newQuoteLabel: UIButton!
    
    private let fetcher = QuoteFetcher()
    
    private var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
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
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
            newQuoteLabel.isHidden = true
        case .expanded:
            updatePreferredContentSize()
            newQuoteLabel.isHidden = false
        }
    }
    
    @IBAction func fetchNewQuote(_ sender: Any) {
        fetchNewQuote()
    }
    
    // MARK: - Private Functions
    
    private func fetchNewQuote() {
        fetcher.fetchQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quote: \(error)")
                return
            }
            self.quote = quote
        }
    }
    
    private func updatePreferredContentSize() {
        let size = quoteLabel.systemLayoutSizeFitting(quoteLabel.bounds.size)
        preferredContentSize = CGSize(width: 0, height: size.height + 100)
    }
    
    private func updateViews() {
        guard let quote = quote else { return }
        
        DispatchQueue.main.async {
            self.quoteLabel.text = quote.quote
            self.authorLabel.text = "- \(quote.author)"
            self.updatePreferredContentSize()
        }
    }
}
