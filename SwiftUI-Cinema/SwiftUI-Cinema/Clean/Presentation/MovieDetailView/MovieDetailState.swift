//
//  MovieDetailState.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 15/05/2024.
//

import Foundation

struct MovieDetailState{
    let movie: Movie
    let errorMessage: String
    let message: String
    let hasError: Bool
    
    func clone(withMovie: Movie? = nil, withErrorMessage: String? = nil, withMessage: String? = nil, withHasError: Bool? = false) -> MovieDetailState{
        return  MovieDetailState(movie: withMovie ?? self.movie,errorMessage: withErrorMessage ?? self.errorMessage, message: withMessage ?? self.message, hasError: withHasError ?? self.hasError)
    }
}
