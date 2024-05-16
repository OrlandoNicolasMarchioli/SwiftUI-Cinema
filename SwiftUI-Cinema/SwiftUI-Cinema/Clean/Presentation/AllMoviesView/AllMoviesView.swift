//
//  AllMoviesView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 06/05/2024.
//

import SwiftUI

struct AllMoviesView: View {
    @ObservedObject var allMoviesViewModel = AllMoviesViewModel(moviesFetchUseCase: DefaultMovieFetchUseCase(allMoviesRepository: MoviesApiFetch(moviesApi: MoviesApi.getInstance())))
    let imageBaseURL: String = ProcessInfo.processInfo.environment["baseImageUrl"] ?? ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    Text("Premieres")
                        .foregroundColor(Color("MovieTitle"))
                        .frame(height: 50)
                        .font(.title)
                        .bold()
                    ScrollView {
                        Grid(alignment: .center, horizontalSpacing: 16, verticalSpacing: 16) {
                            ForEach(allMoviesViewModel.state.moviesNowPlaying) { movie in
                                NavigationLink(destination: MovieDetailView(title: movie.title)) {
                                    MovieCellChip<MovieResult>(item: movie,
                                                               getMovieImageUrl: { item in imageBaseURL + (item.posterPath ?? "") },
                                                               getMovieName: { item in item.title },
                                                               onChipTapped: {
                                    })
                                }
                            }
                        }
                    }
                }
            }.onAppear {
                allMoviesViewModel.fetchAllMoviesData()
            }.onChange(of: allMoviesViewModel.state.moviesNowPlaying ){
                allMoviesViewModel.cleanResponse()
            }
        }
    }
}

#Preview {
    AllMoviesView()
}
