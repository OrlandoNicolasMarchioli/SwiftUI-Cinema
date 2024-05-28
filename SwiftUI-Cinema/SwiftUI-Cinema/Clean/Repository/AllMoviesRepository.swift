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
    private var moviesCacheStore: MoviesCacheStore
    
    init(moviesApi: MoviesApiProtocol, movieStoreManager: MoviesCacheStore) {
        self.moviesApi = moviesApi
        self.moviesCacheStore = movieStoreManager
    }
    
    func fetchNowPlayingMovies() -> AnyPublisher<[MovieResult], Error> {
        return Future<[MovieResult], Error>{ promise in
            if(self.moviesCacheStore.hasAllNowPlayingMovies()){
                promise(.success(self.moviesCacheStore.getMoviesNowPlayingStored()))
            }
            else{
                self.moviesApi.getAllNowPlayingMovies(){ [self] (response, err) in
                    guard let response = response, err == nil else{
                        promise(.failure(MovieStateResponseError.failure))
                        return
                    }
                    moviesCacheStore.saveMovies(movies: response.results)
                    promise(.success(response.results))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchMovieByTitle(title: String) -> AnyPublisher<Movie, Error> {
        return Future<Movie, Error>{ [self] promise in
            if(self.moviesCacheStore.hasTheMovieDetail(movieTitle: title)){
                promise(.success(moviesCacheStore.getMovieStored(title: title)!))
            }
            else{
                self.moviesApi.getMovieByTitle(title: title){ [self] (response, err) in
                    guard let response = response, err == nil else{
                        promise(.failure(MovieStateResponseError.failure))
                        return
                    }
                    moviesCacheStore.saveMovie(movie: response)
                    promise(.success(response))
                }
            }
        }.eraseToAnyPublisher()
    }
}
