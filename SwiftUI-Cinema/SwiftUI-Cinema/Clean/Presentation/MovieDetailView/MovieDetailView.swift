//
//  MovieDetailView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 13/05/2024.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var movieDetailViewModel = MovileDetailViewController( defaultMovieFetchUseCase: DefaultMovieFetchUseCase(allMoviesRepository: MoviesApiFetch(moviesApi: MoviesApi.getInstance())))
    @State  var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    
    var body: some View {
        ZStack{
            VStack{
                SingleMovieCellChip<Movie>(item: movie,
                                           getMovieImageUrl: {item in (  (item.poster ) )},
                                                   getMovieGenre: {item in item.genre}, getMovieDuration: {item in item.runtime }, getMovieActors: {item in item.actors}, getMovieDirector: {item in item.director},
                                           onChipTapped: {
                    
                })
            }
        }.onAppear(){
            movieDetailViewModel.getMovieByTitle(title: movie.title)
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", ratings: [Rating(source: "", value: "")], metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", dvd: "", boxOffice: "", production: "", website: "", response: ""))
}
