//
//  MovieInfoRowView.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 16/05/2024.
//

import SwiftUI

struct MovieInfoRowView: View {
    let label: String
    let value: String
    let labelColor: Color
    let valueColor: Color
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label)
                .foregroundColor(labelColor)
                .font(.title2)
            Text(value)
                .foregroundColor(valueColor)
                .font(.title3)
                .frame(height: 50)
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    MovieInfoRowView(label: "", value: "", labelColor: Color(""), valueColor: Color(""))
}
