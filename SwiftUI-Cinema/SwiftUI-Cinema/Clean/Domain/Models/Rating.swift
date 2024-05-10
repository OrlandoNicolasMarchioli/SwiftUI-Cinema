//
//  Rating.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 08/05/2024.
//

import Foundation

struct Rating: Codable{
    let source: String
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
