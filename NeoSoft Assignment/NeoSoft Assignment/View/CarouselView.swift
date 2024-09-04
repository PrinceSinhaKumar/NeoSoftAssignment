//
//  CarouselView.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 04/09/24.
//

import SwiftUI

struct CarouselView: View {
    @Binding var selectedCarouselId: Int
    let carouselList: [CarouselImage]?
    var body: some View {
        TabView(selection: $selectedCarouselId) {
            ForEach(carouselList ?? []) { image in
                VStack {
                    Image(image.imageUrl)
                        .resizable()
                        .scaledToFill()
                }
                .tag(image.id)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 200)
        .cornerRadius(10)
        .padding(.horizontal, 30)
        
    }
}
struct SelectedCarouselIndicator: View {
    let ids: [Int]
    let selectedId: Int
    var body: some View {
        HStack {
            ForEach(ids, id: \.self) { index in
                Capsule()
                    .fill(selectedId == index ? .blue : .gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.vertical, 5)
    }
}
