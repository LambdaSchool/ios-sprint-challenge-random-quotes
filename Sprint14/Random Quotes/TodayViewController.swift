//
//  TodayViewController.swift
//  Random Quotes
//
//  Created by Vuk Radosavljevic on 10/26/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    let quoteController = QuoteController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quoteController.fetchQuotes { (error) in
            guard error == nil else {return}
            DispatchQueue.main.async {
                let quote = self.quoteController.quotes[Int(arc4random_uniform(9))]
                self.quoteLabel.text = quote.quote
                self.authorLabel.text = quote.author
            }
        }
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
