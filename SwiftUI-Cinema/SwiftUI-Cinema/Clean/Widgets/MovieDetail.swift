//
//  MovieDetail.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 13/05/2024.
//

import Foundation
import SwiftUI

struct MovieDetail<T> {
    
    @State var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        HStack{
            
        }.padding(.bottom)
    }
    
}

struct SingleMovieCellChip<T>: View {
    let item: T
    let getMovieImageUrl: ((T) -> String)
    let getMovieGenre: ((T) -> String)
    let getMovieDuration: ((T) -> String)
    let getMovieActors: ((T) -> String)
    let getMovieDirector: ((T) -> String)
    let onChipTapped: (() -> Void)
    let imageNotAvailable: Constants.NotAvailable = .notAvailable
    
    var body: some View {
        VStack {
            if getMovieImageUrl(item).contains(imageNotAvailable.rawValue){
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .foregroundColor(.red)
            } else {
                AsyncImage(url: URL(string: convertToSecureURL(getMovieImageUrl(item)))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .red))
                            .scaleEffect(2.0, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 700)
                            .cornerRadius(8)
                    case .failure:
                        SpinnerView()
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding()
            }
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline){
                    MovieInfoRowView(label: "Genre: ", value: getMovieGenre(item), labelColor: Color("GrayMovieTitle"), valueColor: Color("MovieTitle"))
                }
                HStack(alignment: .firstTextBaseline){
                    MovieInfoRowView(label: "Duration: ", value: getMovieDuration(item), labelColor: Color("GrayMovieTitle"), valueColor: Color("MovieTitle"))
                }
                HStack(alignment: .firstTextBaseline){
                    MovieInfoRowView(label: "Actors: ", value: getMovieActors(item), labelColor: Color("GrayMovieTitle"), valueColor: Color("MovieTitle"))
                }
                HStack(alignment: .firstTextBaseline){
                    MovieInfoRowView(label: "Director: ", value: getMovieDirector(item), labelColor: Color("GrayMovieTitle"), valueColor: Color("MovieTitle"))
                }
            }
            
        }
    }
}

private func convertToSecureURL(_ urlString: String) -> String {
    var secureURLString = urlString
    if urlString.hasPrefix("http://") {
        secureURLString = "https://" + urlString.dropFirst(7)
    }
    return secureURLString
}
  
#Preview{
    SingleMovieCellChip<SelectedMovie>(item: SelectedMovie(image : "https://placekitten.com/200/300",genre: "Acction", runtime: "94 min", actors: "great kitty", director: "Stephen Hawking"), getMovieImageUrl: {item in return item.image}, getMovieGenre: {item in return item.genre}, getMovieDuration: {item in return item.runtime}, getMovieActors: {item in return item.actors}, getMovieDirector: {item in return item.director}, onChipTapped: {} )
}
