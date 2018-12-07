//
//  ViewController.swift
//  Random Quotes
//
//  Created by Scott Bennett on 12/7/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit
import Random_Quote_Core

class ViewController: UIViewController {
    
    let fetcher = QuoteFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.fetchQuote()
        
    }
}

