//
//  TodayViewController.swift
//  FamousQuotesToday
//
//  Created by Andrew Dhan on 10/26/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabels()
    }
        
    @IBAction func changeQuote(_ sender: Any) {
        updateLabels()
    }
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        quoteController.fetchQuotes { (quote, error) in
            if let error = error{
                NSLog("Error fetching quotes: \(error)")
                completionHandler(NCUpdateResult.failed)
            } else if let quote = quote{
                self.quote = quote
                completionHandler(NCUpdateResult.newData)
            } else{
                completionHandler(NCUpdateResult.noData)
            }
        }
    }
    //MARK: - Private Methods
    private func updateLabels(){
        widgetPerformUpdate { (result) in
            if result == .newData {
                DispatchQueue.main.async {
                    self.quoteLabel.text = " \"\(self.quote.quote)\""
                    self.authorLabel.text = "- \(self.quote.author)"
                }
                
            }
        }
    }
    
    //MARK: -Properties
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    private let quoteController = QuoteController()
    private var quote: Quote!
}
