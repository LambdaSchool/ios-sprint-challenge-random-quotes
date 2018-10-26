//
//  ViewController.swift
//  RandomQuotes
//
//  Created by Linh Bouniol on 10/26/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var quoteController = QuoteController()
    
    var quote: Quote? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets/Actions
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func refresh(_ sender: Any) {
        quoteController.fetchQuote { (quote, error) in
            if let error = error {
                NSLog("Error loading quote: \(error)")
            }
            
            guard let quote = quote else { return }
            
            self.quote = quote
        }
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh(self)
        updateViews()
    }
    
    // MARK: - Methods
    
    private func updateViews() {
        guard let quote = quote, isViewLoaded else { return }
        
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
    }


}

