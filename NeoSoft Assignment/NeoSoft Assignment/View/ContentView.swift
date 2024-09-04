//
//  ContentView.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 03/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: CarouselListViewModel
    @State private var searchText = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(.appBackground)
                .ignoresSafeArea()
            VStack {
                CarouselView(selectedCarouselId: $viewModel.selectedCarouselId,
                             carouselList: viewModel.carouselList?.carouselImages)
                    .onChange(of: viewModel.selectedCarouselId) {
                        searchText = ""
                        viewModel.searchItems(for: searchText)
                    }
                
                SelectedCarouselIndicator(ids: viewModel.ids,
                                          selectedId: viewModel.selectedCarouselId)
                TextField("Search",
                          text: $searchText,
                          onEditingChanged: { _ in
                    viewModel.searchItems(for: searchText)
                })
                .onChange(of: searchText) {
                    viewModel.searchItems(for: searchText)
                }
                .padding([.leading,.trailing], 10)
                .frame(height: 30)
                .background(Color.searchbarBackground)
                .cornerRadius(8)
                .padding(.horizontal, 30)
                
                ListView(filterItem: viewModel.filteredItems)
                
            }
            FloatingView(carouselList:  viewModel.getFloatItem(),
                         selectedFilter: $searchText)
            
        }
        .task {
            Task {
                do {
                    try await viewModel.fetchListData()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: CarouselListViewModel(parser: DataParser()))
}
