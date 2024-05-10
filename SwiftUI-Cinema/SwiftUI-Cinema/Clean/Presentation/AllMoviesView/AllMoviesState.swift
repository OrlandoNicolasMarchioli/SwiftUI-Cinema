//
//  AllMoviesState.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 07/05/2024.
//

import Foundation

struct AllMoviesState{
    
    let moviesNowPlaying: [MovieResult]
    let movies: [Movie]
    let errorMessage: String
    let message: String
    let hasError: Bool
    
    func clone(withMoviesNowPlaying: [MovieResult]? = nil, withMovies: [Movie]? = nil, withErrorMessage: String? = nil, withMessage: String? = nil, withHasError: Bool? = false) -> AllMoviesState{
        return  AllMoviesState(moviesNowPlaying: withMoviesNowPlaying ?? self.moviesNowPlaying, movies: withMovies ?? self.movies,errorMessage: withErrorMessage ?? self.errorMessage, message: withMessage ?? self.message, hasError: withHasError ?? self.hasError)
    }
}
