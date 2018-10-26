//
//  TodayViewController.swift
//  RandomQuotesWidget
//
//  Created by Linh Bouniol on 10/26/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: - Properties
    
    var quoteController = QuoteController()
    
    var quote: Quote? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets/Actions
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func refresh(_ sender: Any) {
        quoteController.fetchQuote { (quote, error) in
            if let error = error {
                NSLog("Error loading quote: \(error)")
            }
            
            guard let quote = quote else { return }
            
            self.quote = quote
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 200)
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        refresh(self)
        updateViews()
       
    }
    
    func updateViews() {
        guard let quote = quote, isViewLoaded else { return }
        
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
    }
    
}
