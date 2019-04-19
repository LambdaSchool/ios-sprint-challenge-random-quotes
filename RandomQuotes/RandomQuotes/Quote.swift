//
//  Quote.swift
//  RandomQuotes
//
//  Created by Julian A. Fordyce on 4/19/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation



struct Quote: Codable {
    let quote: String
    let author: String
    
    init(quote: String, author: String = "Julian") {
        self.quote = quote
        self.author = author
    }
}
