//
//  MainView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 03/05/2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack {
                        AllMoviesView()
                            .frame(maxWidth: .infinity)
                    }
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
