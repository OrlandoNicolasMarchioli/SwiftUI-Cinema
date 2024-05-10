//
//  AllMoviesViewModel.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 06/05/2024.
//

import Foundation
import Combine

class AllMoviesViewModel: ObservableObject{
    @Published var state: AllMoviesState
    static let defaultState = AllMoviesState(moviesNowPlaying: [], movies: [], errorMessage: "", message: "", hasError: false)
    private let moviesFetchUseCase: DefaultMovieFetchUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    init(initialState: AllMoviesState = defaultState, moviesFetchUseCase: DefaultMovieFetchUseCase) {
        self.state = initialState
        self.moviesFetchUseCase = moviesFetchUseCase
    }
    
    func fetchAllMoviesData() -> Void{
        print(self.state)
        fetchNowPlayingMovies()
        print(self.state)
        fetchMovies()
        print(self.state)
    }
    
    func fetchNowPlayingMovies() -> Void{
        moviesFetchUseCase.getNowPlayingMovies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.state = (self?.state.clone(withMoviesNowPlaying: [], withErrorMessage: error.localizedDescription, withMessage: "", withHasError: true))!
                    }
                }
            },
                  receiveValue: {
                movies in DispatchQueue.main.async{
                    self.state = self.state.clone(withMoviesNowPlaying: movies)
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchMovies() -> Void{
        moviesFetchUseCase.getMovies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.state = (self?.state.clone(withMovies: [], withErrorMessage: error.localizedDescription, withMessage: "", withHasError: true))!
                    }
                }
            },
                  receiveValue: {
                movies in DispatchQueue.main.async{
                    self.state = self.state.clone(withMovies: movies)
                }
            })
            .store(in: &cancellables)
    }

}
