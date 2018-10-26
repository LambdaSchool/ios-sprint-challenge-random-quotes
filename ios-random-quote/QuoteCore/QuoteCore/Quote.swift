//
//  Quote.swift
//  ios-random-quote
//
//  Created by Conner on 10/26/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

typealias Quotes = [Quote]

public struct Quote: Codable {
    public let quote, author, category: String
}
