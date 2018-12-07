//
//  TodayViewController.swift
//  QuoteWidget
//
//  Created by Moin Uddin on 12/7/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        widgetPerformUpdate { (result) in
            
        }
    }
    
    func updateViews(_ quote: Quote) {
        self.quoteLabel.text = " \"\(quote.quote)\"  "
        self.authorLabel.text = " - \(quote.author)"
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        QuoteController.shared.getQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quote \(error)")
                completionHandler(NCUpdateResult.noData)
            }
            
            guard let quote = quote else {
                completionHandler(.noData)
                return
            }
            
            DispatchQueue.main.async {
                self.updateViews(quote)
            }
            
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}
