//
//  AllMoviesView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 06/05/2024.
//

import SwiftUI

struct AllMoviesView: View {
    @ObservedObject var allMoviesViewModel = AllMoviesViewModel( moviesFetchUseCase: DefaultMovieFetchUseCase(allMoviesRepository: MoviesApiFetch(moviesApi: MoviesApi.getInstance())))
    @State var movies:  [Movie] = []
    
    var body: some View {
        ZStack{
            Grid(alignment: .center,horizontalSpacing: 16, verticalSpacing: 16){
                ForEach(allMoviesViewModel.state.movies){ movie in
                    MovieCellChip<Movie>(item: movie,
                                         getMovieImageUrl: {item in (item.poster )},
                                              getMovieName: {item in item.title },
                                            onChipTapped: {
                        
                    })
                }
            }
        }.onAppear(){
            allMoviesViewModel.fetchAllMoviesData()
        }
    }
}

#Preview {
    AllMoviesView()
}
