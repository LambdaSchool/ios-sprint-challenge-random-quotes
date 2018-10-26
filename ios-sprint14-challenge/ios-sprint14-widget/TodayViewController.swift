//
//  TodayViewController.swift
//  ios-sprint14-widget
//
//  Created by David Doswell on 10/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import NotificationCenter


class TodayViewController: UIViewController, NCWidgetProviding {
    
    var quote: Quote?
    var quoteController: QuoteController?
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        guard let quote = quote else { return }
        
        quoteController?.fetchQuote(with: quote, completion: { (error) in
            if let error = error {
                NSLog("Error fethcing quote: \(error)")
            }
            self.quoteLabel.text = quote.text
        })
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
