//
//  RandomQuotesViewController.swift
//  Random Quotes
//
//  Created by Ilgar Ilyasov on 12/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import RandomQuotesCore

class RandomQuotesViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    let quoteController = QuoteController()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteController.fetchQuotes { error in
            if let error = error {
                NSLog("Error fetching quotes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.quoteLabel.text = self.quoteController.quotes[0].quote
                self.authorLabel.text = self.quoteController.quotes[0].author
            }
        }
    }
}
