//
//  TodayViewController.swift
//  RandomQuotesWidget
//
//  Created by Ilgar Ilyasov on 12/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import NotificationCenter
import RandomQuotesCore

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: - Properties
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    let quoteController = QuoteController()
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable 'Show more'
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        quoteController.fetchQuotes { (error) in
            if let error = error {
                NSLog("Error fetching quotes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.quoteLabel.text = self.quoteController.quotes[0].quote
                self.authorLabel.text = self.quoteController.quotes[0].author
            }
        }
    }
    
    // MARK: - NCWidgetProviding
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
            quoteLabel.font = UIFont(name: "AvenirNextCondensed-Medium", size: 15)
            authorLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 13)
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 200)
            quoteLabel.font = UIFont(name: "AvenirNextCondensed-Medium", size: 20)
            authorLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 17)
        }
    }
    
}
