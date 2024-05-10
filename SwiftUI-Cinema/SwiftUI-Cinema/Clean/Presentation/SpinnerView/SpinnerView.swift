//
//  SpinnerView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 07/05/2024.
//

import SwiftUI

struct SpinnerView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .red))
            .scaleEffect(2.0, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SpinnerView()
}

