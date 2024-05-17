//
//  SplashScreenView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 16/05/2024.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack{
            VStack{
                Image("splashScreenLogo")
                    .resizable()
                    .frame(maxWidth: 350,maxHeight: 250)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
