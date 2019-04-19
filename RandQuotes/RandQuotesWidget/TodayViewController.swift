//
//  TodayViewController.swift
//  RandQuotesWidget
//
//  Created by Lambda_School_Loaner_95 on 4/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        quoteController.fetchQuotes { (error) in
            if let error = error {
                NSLog("Error fetching quotes in widget: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.quoteLabel.text = self.quoteController.quotes[0].quote
                self.authorLabel.text = "- \(self.quoteController.quotes[0].author)"
            }
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
    let quoteController = QuoteController()
    
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
}
