//
//  ViewController.swift
//  RandomQuote
//
//  Created by Simon Elhoej Steinmejer on 26/10/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import QuoteCore

class ViewController: UIViewController
{
    let testLabel: UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(handleRefresh))
        
        view.addSubview(testLabel)
        testLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        testLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        fetchQuote()
    }
    
    @objc private func handleRefresh()
    {
        fetchQuote()
    }

    private func fetchQuote()
    {
        QuoteController.shared.fetchQuote { (quote, error) in
            
            if let error = error
            {
                print("show alert \(error)")
                return
            }
            
            guard let quote = quote else { return }
            
            DispatchQueue.main.async {
                self.testLabel.text = "\(quote.quote) \n\nBy \(quote.author)"
            }
        }
    }
}

