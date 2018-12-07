//
//  ViewController.swift
//  RandomQuote
//
//  Created by Daniela Parra on 12/7/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchQuote()
    }
    @IBAction func getNewQuote(_ sender: Any) {
        fetchQuote()
    }
    
    private func fetchQuote() {
        fetcher.fetchRandomQuote { (quote, error) in
            if let error = error {
                NSLog("\(error)")
                return
            }
            
            self.quote = quote
        }
    }
    
    private func updateViews() {
        guard let quote = quote else { return }
        
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
    }
    
    private let fetcher = QuoteFetcher()
    private var quote: RandomQuote? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}

