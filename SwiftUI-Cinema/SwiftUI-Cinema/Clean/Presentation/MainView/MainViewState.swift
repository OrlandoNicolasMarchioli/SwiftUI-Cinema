//
//  MainViewState.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 16/05/2024.
//

import Foundation

struct MainViewState{
    let userMode: NavigationMode
    let onAllMoviesview: Bool
    
    func clone (withUserMode: NavigationMode? = nil, withOnAllMoviesview: Bool? = nil) -> MainViewState{
        return MainViewState(userMode: withUserMode ?? self.userMode, onAllMoviesview: withOnAllMoviesview ?? self.onAllMoviesview)
    }
}
