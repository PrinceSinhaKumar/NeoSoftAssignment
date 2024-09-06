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
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(.appBackground)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(alignment: .center, pinnedViews: [.sectionHeaders]) {
                    CarouselView(selectedCarouselId: $viewModel.selectedCarouselId,
                                 carouselList: viewModel.carouselList?.carouselImages)
                    .onChange(of: viewModel.selectedCarouselId) {
                        searchText = ""
                        viewModel.searchItems(for: searchText)
                    }
                    
                    SelectedCarouselIndicator(ids: viewModel.ids,
                                              selectedId: viewModel.selectedCarouselId)
                    Section {
                        ListView(filterItem: viewModel.filteredItems)
                            .background(Color.clear)
                            .padding(.horizontal, 15)
                            .padding(.top, -3)
                            .transition(.move(edge: .leading))
                            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.5), value: viewModel.filteredItems)
                    } header: {
                        SearchBar(searchText: $searchText)
                            .padding(.bottom)
                            .onChange(of: searchText) {
                                viewModel.searchItems(for: searchText)
                            }
                    }
                    
                }
            }
            if viewModel.filteredItems.isEmpty {
                ContentUnavailableView("No data found", systemImage: "doc.text")
            }
            FloatingButton(showSheet: $showSheet)
        }
        .sheet(isPresented: $showSheet) {
            if let statistic = viewModel.floaterItem {
                FloatingView(statistic: statistic)
                    .presentationDetents([.medium, .large])
            }
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
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

#Preview {
    ContentView(viewModel: CarouselListViewModel(parser: DataParser()))
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
