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
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        widgetPerformUpdate { (_) in
            
        }
    }
    
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 300)
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        widgetPerformUpdate { (_) in
            
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
