//
//  QuoteController.swift
//  Famous Quotes
//
//  Created by Andrew Dhan on 10/26/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

class QuoteController{
    
    //MARK: - CRUD
    func add(quote: String, author: String, category: String = "Famous"){
        let newQuote = Quote(quote: quote, author: author, category: category)
        quotes.append(newQuote)
    }
    
    
    //MARK: - Properties
    var quotes = [Quote]()
}
