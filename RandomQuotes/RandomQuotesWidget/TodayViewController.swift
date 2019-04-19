//
//  TodayViewController.swift
//  RandomQuotesWidget
//
//  Created by Lambda_School_Loaner_34 on 4/19/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    //MARK: - Outlets
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
