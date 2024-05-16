//
//  NoMovieFoundView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 16/05/2024.
//

import SwiftUI

struct NoMovieFoundView: View {
    var body: some View {
        ZStack{
            VStack{
                Image(systemName: "movieclapper")
                    .resizable()
                    .frame(maxWidth: 200, maxHeight: 200)
                    .foregroundColor(.red)
                Text("No movies found")
                    .foregroundColor(.red)
                    .bold()
            }
        }
    }
}

#Preview {
    NoMovieFoundView()
}
