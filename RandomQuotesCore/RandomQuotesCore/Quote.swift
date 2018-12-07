//
//  Quote.swift
//  Random Quotes
//
//  Created by Ilgar Ilyasov on 12/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

public struct Quote: Codable {
    
    // MARK: - Properties
    
    public let quote: String
    public let author: String
    
    public init(quote: String, author: String) {
        self.quote = quote
        self.author = author
    }
    
    // MARK: - Decodable
    
    enum QuoteCodingKeys: String, CodingKey {
        case quote
        case author
    }
    
    public init(from decoder: Decoder) throws {
        
        let jsonContainer = try decoder.container(keyedBy: QuoteCodingKeys.self)
        let quote = try jsonContainer.decode(String.self, forKey: .quote)
        let author = try jsonContainer.decode(String.self, forKey: .author)
        
        self.quote = quote
        self.author = author
    }
}
