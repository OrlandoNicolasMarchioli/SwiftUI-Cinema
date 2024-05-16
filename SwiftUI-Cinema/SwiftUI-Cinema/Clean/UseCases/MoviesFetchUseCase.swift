//
//  MoviesFetchUseCase.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 06/05/2024.
//

import Foundation
import Combine

protocol MoviesFetchUseCase{
    func getNowPlayingMovies() -> AnyPublisher<[MovieResult], Error>
    func getMovieByTitle(title: String) -> AnyPublisher<Movie, Error>
}


class DefaultMovieFetchUseCase: MoviesFetchUseCase{

    private let allMoviesRepository: AllMoviesRepository
    
    init(allMoviesRepository: AllMoviesRepository) {
        self.allMoviesRepository = allMoviesRepository
    }
    
    func getNowPlayingMovies() -> AnyPublisher<[MovieResult], Error> {
        return allMoviesRepository.fetchNowPlayingMovies().map{result in
            return result
        }.mapError{err in
            return err
        }
        .eraseToAnyPublisher()
    }
    
    func getMovieByTitle(title: String) -> AnyPublisher<Movie, Error> {
        return allMoviesRepository.fetchMovieByTitle(title: title).map{result in
            return result
        }.mapError{ err in
            return err
        }
        .eraseToAnyPublisher()
    }

}
