//
//  MovileDetailViewControlle.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 13/05/2024.
//

import Foundation
import Combine

class MovileDetailViewModel: ObservableObject{
    
    var defaultMovieFetchUseCase:  DefaultMovieFetchUseCase
    private var cancellables: Set<AnyCancellable> = []
    @Published var state: MovieDetailState
    private static var defaultState = MovieDetailState(movie: Movie(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", ratings: [Rating(source: "", value: "")], metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", dvd: "", boxOffice: "", production: "", website: "", response: ""), errorMessage: "", message: "", hasError: false)
    
    
    init(initialState: MovieDetailState = defaultState,defaultMovieFetchUseCase: DefaultMovieFetchUseCase) {
        self.state = initialState
        self.defaultMovieFetchUseCase = defaultMovieFetchUseCase
    }
    
    func getMovieByTitle(title: String){
        defaultMovieFetchUseCase.getMovieByTitle(title: title)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.state = (self?.state.clone(withMovie: nil, withErrorMessage: error.localizedDescription, withMessage: "", withHasError: true))!
                    }
                }
            },
                  receiveValue: {
                movie in DispatchQueue.main.async{
                    self.state = self.state.clone(withMovie: movie)
                }
            })
            .store(in: &cancellables)
    }
    
}
