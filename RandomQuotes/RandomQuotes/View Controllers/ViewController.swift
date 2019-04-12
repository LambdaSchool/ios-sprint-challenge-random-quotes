//
//  ViewController.swift
//  RandomQuotes
//
//  Created by Nelson Gonzalez on 4/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let quotesController = QuotesController()
    
    var quotes: Quote? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateViews()
        authorLabel.text = nil
    }
    
    private func updateViews() {
        
        guard let quote = quotes else {return}
        DispatchQueue.main.async {
            self.quoteTextView.text = "\(quote.quote)"
            self.authorLabel.text = "- \(quote.author)"
        }
       
    }
    
    private func fetchSingleQuote() {
        activityIndicator.startAnimating()
        quotesController.getQuotes { (quote, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            guard let quote = quote else {return}
            
            self.quotes = quote
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
        }
    }

    @IBAction func fetchQuoteButton(_ sender: UIButton) {
        
        fetchSingleQuote()
        
    }
    
}

