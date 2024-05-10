//
//  FetchMoviesResponse.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 06/05/2024.
//

import Foundation

struct FetchMoviesResponse: Codable{
    let dates: DateMargin
    let page: Int
    let results: [MovieResult]
    let totalPages: Int
    let totalResults: Int

    private enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
