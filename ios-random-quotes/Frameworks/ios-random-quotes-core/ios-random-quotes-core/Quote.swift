//
//  Quote.swift
//  RandomQuotesCore
//
//  Created by De MicheliStefano on 26.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

public struct Quote: Decodable {
    
    let quote: String
    let author: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case quote
        case author
        case category
    }
    
}
