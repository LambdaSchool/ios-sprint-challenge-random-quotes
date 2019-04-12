//
//  TodayViewController.swift
//  RandomQuoteWdiget
//
//  Created by Moses Robinson on 4/12/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit
import NotificationCenter
import RandomQuotesCore

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
