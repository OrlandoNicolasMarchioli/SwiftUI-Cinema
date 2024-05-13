//
//  AllMoviesState.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 07/05/2024.
//

import Foundation

struct AllMoviesState{
    
    let moviesNowPlaying: [MovieResult]
    let errorMessage: String
    let message: String
    let hasError: Bool
    
    func clone(withMoviesNowPlaying: [MovieResult]? = nil, withErrorMessage: String? = nil, withMessage: String? = nil, withHasError: Bool? = false) -> AllMoviesState{
        return  AllMoviesState(moviesNowPlaying: withMoviesNowPlaying ?? self.moviesNowPlaying,errorMessage: withErrorMessage ?? self.errorMessage, message: withMessage ?? self.message, hasError: withHasError ?? self.hasError)
    }
}
