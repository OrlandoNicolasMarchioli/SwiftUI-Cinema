//
//  MoviesStoreManager.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 17/05/2024.
//

import Foundation
import CoreData

class MoviesCacheStore{
    static private var shared: MoviesCacheStore?
    private var allMoviesNowPlayingFetched: [MovieResult] = []
    private var moviesFetchedByTitle: [Movie] = []
    
    
    static func getInstance() -> MoviesCacheStore{
        if let returnShared = shared{
            return shared ?? returnShared
        }else{
            let newInstance =
            MoviesCacheStore()
            shared = newInstance
            return shared ?? newInstance
        }
    }
    
    func hasAllNowPlayingMovies() -> Bool {
        return !self.allMoviesNowPlayingFetched.isEmpty
    }
    
    func hasTheMovieDetail(movieTitle: String) -> Bool{
        for movie in self.moviesFetchedByTitle{
            if(movie.title.contains(movieTitle)){
                return true
            }
        }
        return false
    }
    
    func getMoviesNowPlayingStored() -> [MovieResult]{
        return self.allMoviesNowPlayingFetched
    }
    
    func getMovieStored(title: String) -> Movie?{
        return searchMovieByTitle(title: title)
    }
    
    func getMoviesByTitleStored() -> [Movie]{
        return self.moviesFetchedByTitle
    }
    
    private func searchMovieByTitle(title: String) -> Movie?{
        let filteredMovies = self.moviesFetchedByTitle.filter{ $0.title == title}
        return filteredMovies.first
    }
    
    func saveMovies(movies: [MovieResult]) -> Void {
        self.allMoviesNowPlayingFetched = movies
    }
    
    func saveMovie(movie: Movie) -> Void{
        self.moviesFetchedByTitle.append(movie)
    }
}
