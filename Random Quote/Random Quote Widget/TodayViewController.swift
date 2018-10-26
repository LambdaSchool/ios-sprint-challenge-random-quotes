//
//  TodayViewController.swift
//  Random Quote Widget
//
//  Created by Samantha Gatt on 10/26/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        quoteLabel.text = ""
        authorLabel.text = ""
        
        fetchAQuote()
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
            quoteLabel.numberOfLines = 1
            authorLabel.isHidden = true
        case .expanded:
            let quoteHeight = quoteLabel.frame.size.height
            let authorHeight = authorLabel.frame.size.height
            let preferredHeight = quoteHeight + authorHeight + 38.0
            preferredContentSize = CGSize(width: maxSize.width, height: preferredHeight)
            quoteLabel.numberOfLines = 0
            authorLabel.isHidden = false
        }
    }
    
    
    // MARK: - Private Properties
    
    let quoteController = QuoteController()
    var quote: Quote?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    // MARK: - Private Functions
    
    private func updateViews() {
        DispatchQueue.main.async {
            self.quoteLabel.text = "\"\(self.quote?.quote ?? "Oops, looks like there was an error fetching your random quote")\""
            self.authorLabel.text = "-\(self.quote?.author ?? "- Random Quote Staff")"
        }
    }
    
    private func fetchAQuote() {
        quoteController.fetchQuote { (quote, error) in
            
            if let error = error {
                NSLog("Error with fetch: \(error)")
                return
            }
            
            guard let quote = quote else {
                NSLog("Quote was nil")
                return
            }
            
            self.quote = quote
            
            self.updateViews()
        }
    }
}
