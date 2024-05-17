//
//  MainViewModel.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 16/05/2024.
//

import Foundation

class MainViewModel: ObservableObject{
    @Published var state: MainViewState
    private static var defaultState  =  MainViewState(userMode: .admin, onAllMoviesview: false)
    
    init(initialState: MainViewState = defaultState) {
        self.state = initialState
    }
    
    func onAppInit() -> Void {
        
    }
}
