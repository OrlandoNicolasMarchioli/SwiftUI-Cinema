//
//  MovileDetailViewControlle.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 13/05/2024.
//

import Foundation
import Combine

class MovileDetailViewController: ObservableObject{
    
    var defaultMovieFetchUseCase:  DefaultMovieFetchUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    init(defaultMovieFetchUseCase: DefaultMovieFetchUseCase) {
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
    
}
