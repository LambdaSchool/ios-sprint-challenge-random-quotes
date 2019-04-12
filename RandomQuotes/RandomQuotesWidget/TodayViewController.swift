//
//  TodayViewController.swift
//  RandomQuotesWidget
//
//  Created by Nelson Gonzalez on 4/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var fetchQuoteButton: UIButton!
    
    let quotesController = QuotesController()
    
    var quotes: Quote? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        authorLabel.text = nil
    }
    
    private func updateViews() {
        
        guard let quote = quotes, isViewLoaded else {return}
        DispatchQueue.main.async {
            self.quoteTextView.text = "\(quote.quote)"
            self.authorLabel.text = "- \(quote.author)"
        }
        
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
            quoteTextView.isHidden = true
            authorLabel.isHidden = true
            fetchQuoteButton.isHidden = true
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 300)
            quoteTextView.isHidden = false
            authorLabel.isHidden = false
            fetchQuoteButton.isHidden = false
        @unknown default:
            break
        }
    }
    
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        self.updateViews()
        
        completionHandler(NCUpdateResult.newData)
    }
    
    private func fetchSingleQuote() {
        
        quotesController.getQuotes { (quote, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            guard let quote = quote else {return}
            
            self.quotes = quote
            
        }
    }
    
    
    @IBAction func fetchQuoteButtonPressed(_ sender: UIButton) {
        
        fetchSingleQuote()
    }
    
}
