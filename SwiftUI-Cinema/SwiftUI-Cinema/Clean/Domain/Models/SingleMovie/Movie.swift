//
//  Movie.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 13/05/2024.
//

import Foundation

struct Movie: Codable{
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    let ratings: [Rating]
    let metascore: String
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let type: String
    let dvd: String
    let boxOffice: String
    let production: String
    let website: String
    let response: String
}
