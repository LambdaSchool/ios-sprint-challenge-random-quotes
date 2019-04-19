//
//  InterfaceController.swift
//  RandQuotes-watchOS Extension
//
//  Created by Lambda_School_Loaner_95 on 4/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        quoteController.fetchQuotes { (error) in
            if let error = error {
                NSLog("Error fetching in watch OS: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.quoteLabel.setText(self.quoteController.quotes[0].quote)
                self.authorLabel.setText("- \(self.quoteController.quotes[0].author)")
            }
        }
    }
   
    let quoteController = QuoteController()
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    

}
