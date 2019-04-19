//
//  ViewController.swift
//  RandQuotes
//
//  Created by Lambda_School_Loaner_95 on 4/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        quoteController.fetchQuotes { (error) in
            if let error = error {
                NSLog("Error fetching in view did load: \(error)")
                return
            }
            DispatchQueue.main.async {
                print("Quote from view controller: \(self.quoteController.quotes[0].quote)")
            }
        }
    }
    
    let quoteController = QuoteController()

}

