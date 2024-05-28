//
//  AllMoviesView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 06/05/2024.
//

import SwiftUI

struct AllMoviesView: View {
    @ObservedObject var allMoviesViewModel = AllMoviesViewModel(moviesFetchUseCase: DefaultMovieFetchUseCase(allMoviesRepository: MoviesApiFetch(moviesApi: MoviesApi.getInstance(), movieStoreManager: MoviesCacheStore.getInstance()
                                                                                    )))
    let imageBaseURL: String = ProcessInfo.processInfo.environment["baseImageUrl"] ?? ""
    @State var filterName: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    VStack(alignment: .center) {
                        VStack(alignment: .trailing){
                            HStack(){
                                Spacer()
                                TextField("Search Movie: ", text: $filterName)
                                    .foregroundColor(Color.white)
                                    .frame(minWidth: 100)
                                    .padding(.leading)

                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.red)
                                        .bold()
                                        .padding(.trailing)
                            }
                        }
                        .frame(width: geometry.size.width)
                        Text("Premieres")
                            .foregroundColor(Color("MovieTitle"))
                            .frame(height: 50)
                            .font(.title)
                            .bold()
                        if(!allMoviesViewModel.state.noMoviesFound){
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
                        else{
                            Spacer()
                            NoMovieFoundView()
                            Spacer()
                        }
                    }
                }.onAppear {
                    allMoviesViewModel.fetchAllMoviesData()
                }.onChange(of: allMoviesViewModel.state.moviesNowPlaying ){
                    allMoviesViewModel.cleanResponse()
                }.onChange(of: filterName){
                    allMoviesViewModel.searchMovies(title: filterName)
                }
            }
        }
    }
}

#Preview {
    AllMoviesView()
}
