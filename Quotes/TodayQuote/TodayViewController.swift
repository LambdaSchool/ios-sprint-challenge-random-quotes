//
//  TodayViewController.swift
//  TodayQuote
//
//  Created by Carolyn Lea on 10/26/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding
{
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    let quoteController = QuoteController()
    var quote: Quote?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        quoteLabel.text = ""
        authorLabel.text = ""
        
        quoteController.fetchQuote { (quote, error) in
            
            if let error = error {
                NSLog("Error fetching: \(error)")
                return
            }
            
            guard let quote = quote else {
                NSLog("No quote")
                return
            }
            
            self.quote = quote
            
            self.updateViews()
        }
    }
        
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize)
    {
        switch activeDisplayMode {
            case .compact:
                preferredContentSize = maxSize
                quoteLabel.numberOfLines = 1
                authorLabel.isHidden = true
            case .expanded:
                preferredContentSize = CGSize(width: maxSize.width, height: 200)
                quoteLabel.numberOfLines = 0
                authorLabel.isHidden = false
        }
    }
    
    private func updateViews()
    {
        DispatchQueue.main.async {
            
            self.quoteLabel.text = self.quote?.quote ?? ""
            self.authorLabel.text = self.quote?.author ?? ""
        }
    }
}
