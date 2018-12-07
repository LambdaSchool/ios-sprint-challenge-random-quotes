//
//  Quote.swift
//  Random Quote-Core
//
//  Created by Scott Bennett on 12/7/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

public struct Quote: Decodable {
    public let quote: String
    public let author: String
    public let category: String
}
