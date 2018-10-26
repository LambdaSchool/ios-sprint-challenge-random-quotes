//
//  TodayViewController.swift
//  QuoteWidget
//
//  Created by Conner on 10/26/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit
import NotificationCenter
import QuoteCore

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: - IBOutlets
    @IBOutlet var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
}
