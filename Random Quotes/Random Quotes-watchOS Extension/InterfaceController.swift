//
//  InterfaceController.swift
//  Random Quotes-watchOS Extension
//
//  Created by Scott Bennett on 12/7/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let quote = """
        "It's always everything!"
        """
        
        quoteLabel.setText(quote)
        authorLabel.setText("-Scott Bennett")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
