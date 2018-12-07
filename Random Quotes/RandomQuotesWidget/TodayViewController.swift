//
//  TodayViewController.swift
//  RandomQuotesWidget
//
//  Created by Scott Bennett on 12/7/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    let quote = """
        "It's always everything!"
        """
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteLabel.text = quote
        authorLabel.text = "-Scott Bennett"
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {

        
        completionHandler(NCUpdateResult.newData)
    }
    
}
