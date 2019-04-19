//
//  TodayViewController.swift
//  RandomQuotesWidget
//
//  Created by Lambda_School_Loaner_34 on 4/19/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit
import NotificationCenter
import RandomQuotesCore

class TodayViewController: UIViewController, NCWidgetProviding {
    
    //MARK: - Properties
    let quoteController = QuoteController()
    var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        quoteController.fetchRandomQuote { (quote, error) in
            if let error = error {
                NSLog("Found error trying to retrieve quote: \(error)")
                return
            }
            
            self.quote = quote
        }
        completionHandler(NCUpdateResult.newData)
    }
    
    private func updateViews() {
        guard let quote = quote, isViewLoaded else { return }
        
        quoteLabel.text = "\"\(quote.quote)\""
        authorLabel.text = "- \(quote.author)"
    }
}
