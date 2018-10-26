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
        
        
        updateViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func reset(_ sender: Any) {
        updateViews()
    }
    
    func updateViews() {
        quoteController.fetchSingleQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quote in viewController: \(error)")
                return
            }
            guard let quote = quote else { return }
            self.quote = quote
        }
        //quoteController.fetchSingleQuote()
    }
    
    let quoteController = QuoteController()
    var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                if let quote = self.quote {
                    self.quoteLabel.text = quote.quote
                    self.authorLabel.text = quote.author
                }
            }
        }
    }
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}

