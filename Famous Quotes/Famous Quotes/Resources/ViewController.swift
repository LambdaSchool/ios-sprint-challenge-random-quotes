//
//  ViewController.swift
//  Famous Quotes
//
//  Created by Andrew Dhan on 10/26/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let quoteController = QuoteController()
        quoteController.fetchQuotes { (quote, error) in
            if let error = error {
                NSLog("Error decdoing: \(error)")
                return
            }
        }
    }


}

