//
//  AllMoviesRepository.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 06/05/2024.
//

import Foundation
import Combine

protocol AllMoviesRepository{
    func fetchNowPlayingMovies() -> AnyPublisher<[MovieResult], Error>
    func fetchMovieByTitle(title: String) -> AnyPublisher<Movie, Error>
}

class MoviesApiFetch: AllMoviesRepository{
    private var moviesApi: MoviesApiProtocol
    private var moviesStoreManager: MoviesStoreManager
    
    init(moviesApi: MoviesApiProtocol, movieStoreManager: MoviesStoreManager = MoviesStoreManager.getInstance()) {
        self.moviesApi = moviesApi
        self.moviesStoreManager = movieStoreManager
    }
    
    func fetchNowPlayingMovies() -> AnyPublisher<[MovieResult], Error> {
        return Future<[MovieResult], Error>{ promise in
            if(self.moviesStoreManager.hasAllNowPlayingMovies()){
                promise(.success(self.moviesStoreManager.getMoviesNowPlayingStored()))
            }
            else{
                self.moviesApi.getAllNowPlayingMovies(){ (response, err) in
                    guard let response = response, err == nil else{
                        promise(.failure(MovieStateResponseError.failure))
                        return
                    }
                    self.moviesStoreManager.state = self.moviesStoreManager.state.clone(withHasAllMoviesNowPlaying: response.results)
                    promise(.success(response.results))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchMovieByTitle(title: String) -> AnyPublisher<Movie, Error> {
        return Future<Movie, Error>{ promise in
            if(self.moviesStoreManager.hasTheMovieDetail(movieTitle: title)){
                promise(.success(self.moviesStoreManager.getMovieStored(title: title)!))
            }
            else{
                self.moviesApi.getMovieByTitle(title: title){ (response, err) in
                    guard let response = response, err == nil else{
                        promise(.failure(MovieStateResponseError.failure))
                        return
                    }
                    var movies = self.moviesStoreManager.state.moviesFetchedByTitle
                    movies.append(response)
                    self.moviesStoreManager.state = self.moviesStoreManager.state.clone(withMoviesFetchedByTitle: movies)
                    promise(.success(response))
                }
            }
        }.eraseToAnyPublisher()
    }
}
