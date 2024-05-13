//
//  MainView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 03/05/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center){
                ScrollView{
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                        AllMoviesView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }.background(Color.black)
        }
    }
}

#Preview {
    MainView()
}
