//
//  TodayViewController.swift
//  RandomQuotesExtension
//
//  Created by De MicheliStefano on 26.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit
import NotificationCenter
import RandomQuotesCore

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    let randomQuoteClient = RandomQuoteClient()
    var randomQuote: Quote? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomQuoteClient.fetchRandomQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quotes: \(error)")
                return
            }
            
            guard let quote = quote else { return }
            
            DispatchQueue.main.async {
                self.randomQuote = quote
            }
        }
    }
    
    private func updateViews() {
        quoteLabel?.text = "\"\(randomQuote?.quote ?? "")\""
        authorLabel?.text = "- \(randomQuote?.author ?? "")"
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
