//
//  SwiftUI_CinemaApp.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 02/05/2024.
//

import SwiftUI

@main
struct SwiftUI_CinemaApp: App {
    @StateObject var navigationManager = NavigationManager.shared()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                switch navigationManager.state{
                case .allMovies:
                    MainView()
                case .splash:
                    SplashScreenView()
                case .admin:
                    EmptyView()
                case .user:
                    EmptyView()
                }
            }.onAppear(){
                if(navigationManager.state == .splash){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        navigationManager.onAppInit()
                    }
                }else{
                    navigationManager.onAppInit()
                }
            }
        }
    }
}
