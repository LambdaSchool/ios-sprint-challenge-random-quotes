//
//  TodayViewController.swift
//  RandomQuotesTodayExtension
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .compact
        updateViews()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    private func updateViews() {
        quoteController.fetchSingleQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quote in viewController: \(error)")
                return
            }
            guard let quote = quote else { return }
            self.quote = quote
        }
    }
    
    let quoteController = QuoteController()
    var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                if let quote = self.quote {
                    self.quoteLabel.text = "\"\(quote.quote)\""
                    self.authorLabel.text = "- \(quote.author)"
                }
            }
        }
    }
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}
