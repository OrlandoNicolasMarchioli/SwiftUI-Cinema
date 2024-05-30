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
    static let defaultState = AllMoviesState(moviesNowPlaying: [], errorMessage: "", message: "", hasError: false, noMoviesFound: false)
    private let moviesFetchUseCase: DefaultMovieFetchUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    init(initialState: AllMoviesState = defaultState, moviesFetchUseCase: DefaultMovieFetchUseCase) {
        self.state = initialState
        self.moviesFetchUseCase = moviesFetchUseCase
    }
    
    func fetchAllMoviesData() -> Void{
        fetchNowPlayingMovies()
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
    
    // TODO: Implement a better way to do this filtering
    //This function cleans the response, because exists one movie with movie detail response (Directors, Actors, Time, etc)
    func cleanResponse() -> Void{
        self.state = self.state.clone(withMoviesNowPlaying:
                                        self.state.moviesNowPlaying
                                        .filter{ $0.title != ProcessInfo.processInfo.environment["movieWithoutInfo"]})
    }
    
    func searchMovies(title: String) -> Void{
        if (title.isEmpty){
            fetchNowPlayingMovies()
        }
        
        let filteredMovies = self.state.moviesNowPlaying.filter{ $0.title.lowercased().contains(title.lowercased())}
        
        guard !filteredMovies.isEmpty else{
            self.state  = self.state.clone(withNoMoviesFound: true)
            return
        }
        self.state = self.state.clone(withMoviesNowPlaying: filteredMovies)
    }
    
}
