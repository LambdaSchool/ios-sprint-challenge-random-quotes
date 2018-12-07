//
//  TodayViewController.swift
//  RQ-TodayExtention
//
//  Created by Farhan on 12/7/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var displayQuote: Quote?{
        didSet{
            DispatchQueue.main.async {
                self.updateLabel()
            }
        }
    }
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    
    @IBAction func newQuote(_ sender: Any) {
        let qc = QuoteController()
        qc.fetchRandomQuote { (quote, _) in
            self.displayQuote = quote
        }
    }
    
    func updateLabel(){
        guard let displayQuote = displayQuote else {return}
        quoteLabel.text = displayQuote.quote + " - " + displayQuote.author
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newQuote(self)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if (activeDisplayMode == .compact){
            // Changed to compact mode
            self.preferredContentSize = maxSize;
        }
        else{
            // Changed to expanded mode
            self.preferredContentSize = maxSize
        }
    }
    
}
