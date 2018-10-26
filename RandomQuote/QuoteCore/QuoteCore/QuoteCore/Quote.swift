//
//  Quote.swift
//  RandomQuote
//
//  Created by Simon Elhoej Steinmejer on 26/10/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation

public struct Quote: Decodable
{
    public var quote: String
    public var author: String
    public var category: String
    
    enum CodingKeys: String, CodingKey
    {
        case quote
        case author
        case category
    }
    
    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let quote = try container.decode(String.self, forKey: .quote)
        let author = try container.decode(String.self, forKey: .author)
        let category = try container.decode(String.self, forKey: .category)
        
        self.quote = quote
        self.author = author
        self.category = category
    }
}
