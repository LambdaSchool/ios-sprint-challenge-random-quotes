//
//  TodayViewController.swift
//  RandomQuoteWidget
//
//  Created by Simon Elhoej Steinmejer on 26/10/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import NotificationCenter
import QuoteCore

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        refreshButton.setImage(UIImage(named: "refresh")?.withRenderingMode(.alwaysTemplate), for: .normal)
        refreshButton.tintColor = .darkGray
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        QuoteController.shared.fetchQuote { (quote, error) in
            
            if let error = error
            {
                NSLog("Error fetching quote: \(error)")
                completionHandler(.failed)
                return
            }
            
            guard let quote = quote else {
                NSLog("Failed to unwrap quote")
                completionHandler(.noData)
                return
            }
            
            self.setupViews(with: quote)
            completionHandler(.newData)
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @IBAction func handleRefresh(_ sender: Any)
    {
        QuoteController.shared.fetchQuote { (quote, error) in
            
            if let error = error
            {
                NSLog("Error fetching quote: \(error)")
                return
            }
            
            guard let quote = quote else {
                NSLog("Failed to unwrap quote")
                return
            }
            
            self.setupViews(with: quote)
        }
    }
    
    private func setupViews(with quote: Quote)
    {
        DispatchQueue.main.async {
            self.authorLabel.text = "- \(quote.author)"
            self.quoteLabel.text = "\"\(quote.quote)\""
        }
    }
}

