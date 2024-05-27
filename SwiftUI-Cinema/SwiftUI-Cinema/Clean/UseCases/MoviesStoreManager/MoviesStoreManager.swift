//
//  MoviesStoreManager.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 17/05/2024.
//

import Foundation
import CoreData

class MoviesStoreManager{
    static private var shared: MoviesStoreManager?
    var state: MovieStoreManagerState
    static var defaultState = MovieStoreManagerState(allMoviesNowPlayingFetched: [], moviesFetchedByTitle: [])
    
    init(initialState: MovieStoreManagerState = defaultState) {
        self.state = initialState
    }
    
    static func getInstance() -> MoviesStoreManager{
        if let returnShared = shared{
            return shared ?? returnShared
        }else{
            // TODO: Do constructor networking outside class
            let newInstance =
            MoviesStoreManager()
            shared = newInstance
            return shared ?? newInstance
        }
    }
    
    func hasAllNowPlayingMovies() -> Bool {
        return !self.state.allMoviesNowPlayingFetched.isEmpty
    }
    
    func hasTheMovieDetail(movieTitle: String) -> Bool{
        for movie in self.state.moviesFetchedByTitle{
            if(movie.title.contains(movieTitle)){
                return true
            }
        }
        return false
    }
    
    func getMoviesNowPlayingStored() -> [MovieResult]{
        return self.state.allMoviesNowPlayingFetched
    }
    
    func getMovieStored(title: String) -> Movie?{
        return searchMovieByTitle(title: title)
    }
    
    func getMoviesByTitleStored() -> [Movie]{
        return self.state.moviesFetchedByTitle
    }
    
    private func searchMovieByTitle(title: String) -> Movie?{
        let filteredMovies = self.state.moviesFetchedByTitle.filter{ $0.title == title}
        return filteredMovies.first
    }
}
