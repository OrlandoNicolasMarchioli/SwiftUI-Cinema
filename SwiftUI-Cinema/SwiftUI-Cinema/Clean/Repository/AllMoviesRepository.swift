//
//  AllMoviesRepository.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 06/05/2024.
//

import Foundation
import Combine

protocol AllMoviesRepository{
    func fetchNowPlayingMovies() -> AnyPublisher<[MovieResult],Error>
    func fetchAllMovies() -> AnyPublisher<[Movie],Error>
}

class MoviesApiFetch: AllMoviesRepository{
    private var moviesApi: MoviesApiProtocol
    
    init(moviesApi: MoviesApiProtocol) {
        self.moviesApi = moviesApi
    }
    
    func fetchNowPlayingMovies() -> AnyPublisher<[MovieResult], Error> {
        return Future<[MovieResult], Error>{ promise in
            self.moviesApi.getAllNowPlayingMovies(){ (response, err) in
                guard let response = response, err == nil else{
                    promise(.failure(MovieStateResponseError.failure))
                    return
                }
                promise(.success(response.results))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchAllMovies() -> AnyPublisher<[Movie], Error> {
        return Future<[Movie], Error>{ promise in
            self.moviesApi.getAllMovies(){ (response, err) in
                guard let response = response, err == nil else{
                    promise(.failure(MovieStateResponseError.failure))
                    return
                }
                promise(.success(response))
            }
        }
        .eraseToAnyPublisher()
    }
    
}
