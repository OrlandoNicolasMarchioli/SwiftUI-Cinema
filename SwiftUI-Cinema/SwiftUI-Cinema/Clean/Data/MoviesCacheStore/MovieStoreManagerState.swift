//
//  MovieStoreManagerState.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 17/05/2024.
//

import Foundation

struct MovieStoreManagerState{
    let allMoviesNowPlayingFetched: [MovieResult]
    let moviesFetchedByTitle: [Movie]
    
    func clone (withHasAllMoviesNowPlaying: [MovieResult]? = nil, withMoviesFetchedByTitle: [Movie]? = nil) -> MovieStoreManagerState{
        return MovieStoreManagerState(allMoviesNowPlayingFetched: withHasAllMoviesNowPlaying ?? self.allMoviesNowPlayingFetched, moviesFetchedByTitle: withMoviesFetchedByTitle ?? self.moviesFetchedByTitle)
    }
}
