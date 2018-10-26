//
//  ViewController.swift
//  Random Quotes
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        quoteController.fetchSingleQuote()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func reset(_ sender: Any) {
        updateViews()
    }
    
    func updateViews() {
        //quoteController.fetchSingleQuote()
        DispatchQueue.main.async {
            if let quote = self.quoteController.quote {
                self.quoteLabel.text = quote.quote
                self.authorLabel.text = quote.author
            }
        }
    }
    
    let quoteController = QuoteController()
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}

