//
//  NavigationManagerr.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 17/05/2024.
//

import Foundation

class NavigationManager: ObservableObject{
    @Published var state: NavigationMode
    static var initialState: NavigationMode = .splash
    static var instance: NavigationManager?
    
    static public func shared() -> NavigationManager{
        if self.instance == nil{
            return NavigationManager()
        }
        return self.instance!
    }
    
    private init(initialState: NavigationMode = NavigationMode.splash) {
        self.state = initialState
    }
    
    func onAppInit(){
        
        switch state {
        case .allMovies:
            self.state = .splash
        case .splash:
            self.state = .allMovies
        case .admin:
            self.state = .admin
        case .user:
            self.state  = .user
        }
    }
    
    
}
