//
//  MovieDetailView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 13/05/2024.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var movieDetailViewModel = MovileDetailViewModel( defaultMovieFetchUseCase: DefaultMovieFetchUseCase(allMoviesRepository: MoviesApiFetch(moviesApi: MoviesApi.getInstance(), movieStoreManager: MoviesStoreManager())))
    @State  var title: String
    
    init(title: String) {
        self.title = title
    }
    
    
    var body: some View {
        ZStack{
            VStack{
                SingleMovieCellChip<Movie>(item: movieDetailViewModel.state.movie,
                                           getMovieImageUrl: {item in (  (item.poster ) )},
                                                   getMovieGenre: {item in item.genre}, getMovieDuration: {item in item.runtime }, getMovieActors: {item in item.actors}, getMovieDirector: {item in item.director},
                                           onChipTapped: {
                    
                })
            }
        }.onAppear(){
            movieDetailViewModel.getMovieByTitle(title: title)
        }
    }
}

#Preview {
    MovieDetailView(title: "")
}
