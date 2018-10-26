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
        newQuoteButton.isEnabled = false
        
        fetchAQuote()
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
            quoteLabel.numberOfLines = 1
            authorLabel.isHidden = true
            newQuoteStackView.axis = .horizontal
        case .expanded:
            let contentHeight = quoteLabel.frame.size.height + authorLabel.frame.size.height + newQuoteButton.frame.size.height
            let spacingHeight: CGFloat = 12.0 + 10.0 + 10.0 + 12.0
            let preferredHeight = contentHeight + spacingHeight
            preferredContentSize = CGSize(width: maxSize.width, height: preferredHeight)
            quoteLabel.numberOfLines = 0
            authorLabel.isHidden = false
            newQuoteStackView.axis = .vertical
        }
    }
    
    
    // MARK: - Private Properties
    
    let quoteController = QuoteController()
    var quote: Quote?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var newQuoteStackView: UIStackView!
    
    
    // MARK: - Private Functions
    
    private func updateViews() {
        DispatchQueue.main.async {
            self.quoteLabel.text = "\"\(self.quote?.quote ?? "Oops, looks like there was an error fetching your random quote")\""
            self.authorLabel.text = "-\(self.quote?.author ?? "- Random Quote Staff")"
            self.newQuoteButton.isEnabled = true
        }
    }
    
    private func fetchAQuote() {
        
        newQuoteButton.isEnabled = false
        
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
    
    
    // MARK: - Actions
    
    @IBAction func fetchNewQuote(_ sender: Any) {
        fetchAQuote()
    }
}
