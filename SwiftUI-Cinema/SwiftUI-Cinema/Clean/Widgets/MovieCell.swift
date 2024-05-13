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
            Text(getMovieName(item))
                .foregroundColor(Color("MovieTitle"))
                .frame(height: 50)
                .font(.title2)
                .padding(.bottom,20)
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
    MovieCellChip<SelectedMovieData>(item: SelectedMovieData(movieName: "Kitten Fight", imageUrl: "https://placekitten.com/200/300"), getMovieImageUrl: {item in return item.imageUrl}, getMovieName: {item in return item.movieName}, onChipTapped: {} )
}
