//
//  MovieCell.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 07/05/2024.
//

import Foundation
import SwiftUI

struct MovieCell<T>: View {
    @State var movie: Character
    
    init(movie: Character) {
        self.movie = movie
    }
    
    var body: some View {
        HStack{
            
        }.padding(.bottom)
    }
}

struct MovieCellChip<T>: View {
    let item: T
    let getMovieImageUrl: ((T) -> String)
    let getMovieName: ((T) -> String)
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
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(8)
                    case .failure:
                        SpinnerView()
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding()
            }
            Text(getMovieName(item))
                .foregroundColor(Color("MovieTitle"))
                .frame(height: 50)
                .font(.headline)
                .padding(.top, 3)
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
    MovieCellChip<SelectedMovieData>(item: SelectedMovieData(imageUrl: "https://placekitten.com/200/300", movieName: "Kitten Fight"), getMovieImageUrl: {item in return item.imageUrl}, getMovieName: {item in return item.movieName}, onChipTapped: {} )
}
