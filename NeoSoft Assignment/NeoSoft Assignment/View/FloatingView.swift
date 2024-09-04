//
//  FloatingView.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 04/09/24.
//

import SwiftUI

struct FloatingView: View {
    var carouselList: [String]?
    @Binding var selectedFilter: String
    var body: some View {
        Menu {
            ForEach(carouselList ?? [], id: \.self) { item in
                Button(item) {
                    selectedFilter = item
                }
            }
        } label: {
            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90))
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
        }
        .background(.blue)
        .cornerRadius(25)
        .shadow(radius: 10)
        .padding()
        
        
    }
}
