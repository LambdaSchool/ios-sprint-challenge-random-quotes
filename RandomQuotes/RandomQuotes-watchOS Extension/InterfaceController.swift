//
//  InterfaceController.swift
//  RandomQuotes-watchOS Extension
//
//  Created by Lambda_School_Loaner_34 on 4/19/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    //MARK: - Properties
    
    //MARK: - Outlets
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

}
