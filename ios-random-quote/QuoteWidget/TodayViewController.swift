//
//  TodayViewController.swift
//  QuoteWidget
//
//  Created by Conner on 10/26/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit
import NotificationCenter
import QuoteCore

class TodayViewController: UIViewController, NCWidgetProviding {
    // MARK: - Properties
    let quoteController = QuoteController()
    
    // MARK: - IBOutlets
    @IBOutlet var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .compact
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        quoteController.getQuote { (quote, error) in
            if let error = error {
                NSLog("No quote, error: \(error)")
                completionHandler(NCUpdateResult.failed)
                return
            }
            
            guard let quote = quote else {
                completionHandler(NCUpdateResult.noData)
                return
            }
            
            DispatchQueue.main.async {
                self.quoteLabel.text = "\(quote.quote) - \(quote.author)"
            }
        }
        completionHandler(NCUpdateResult.newData)
    }
    
}
