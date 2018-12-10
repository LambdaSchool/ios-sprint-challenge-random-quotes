//
//  ViewController.swift
//  RandomQuote
//
//  Created by Scott Bennett on 12/9/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: - Properites
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    let fetcher = QuoteFetcher()
    
    private var quote: Quote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNewQuote()
    }

    @IBAction func fetchQuoteButton(_ sender: Any) {
        fetchNewQuote()
    }
    
    // MARK: - Private Functions
    
    private func fetchNewQuote() {
        fetcher.fetchQuote { (quote, error) in
            if let error = error {
                NSLog("Error fetching quote: \(error)")
                return
            }
            self.quote = quote
        }
    }
    
    private func updateViews() {
        guard let quote = quote else { return }
        
        quoteLabel.text = quote.quote
        authorLabel.text = "- \(quote.author)"
        categoryLabel.text = quote.category
    }
    
}

