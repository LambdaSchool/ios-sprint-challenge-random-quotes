//
//  TodayViewController.swift
//  RandomQuotesWidget
//
//  Created by Nathanael Youngren on 4/19/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        quoteController.fetchQuote { (quote, error) in
            if let error = error {
                print("Error during fetchQuote method: \(error).")
                return
            }

            self.quote = quote
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
        case .expanded:
            let contentHeight = quoteLabel.frame.height + authorLabel.frame.height + 56
            preferredContentSize = CGSize(width: maxSize.width, height: contentHeight)
        default:
            break
        }
    }
    
    func updateViews() {
        if let quote = quote {
            quoteLabel.text = "\"" + quote.quote + "\""
            let author = "- " + quote.author
            authorLabel.text = author
        }
    }
    
    var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    let quoteController = QuoteController()
}
