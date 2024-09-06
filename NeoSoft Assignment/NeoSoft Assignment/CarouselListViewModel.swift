//
//  CarouselListViewModel.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 03/09/24.
//

import Foundation

class CarouselListViewModel: ObservableObject {
    
    @Published var carouselList: CarouselListModel?
    @Published var filteredItems: [ListItem] = []
    @Published var floaterItem: FloaterItem?
    @Published var selectedCarouselId = 1
    
    var numberOfItem: Int {
        return carouselList?.carouselImages.count ?? 0
    }
    var ids: [Int] {
        return carouselList?.carouselImages.map({$0.id}) ?? []
    }
    
    var parser: Parser
    init(parser: Parser) {
        self.parser = parser
    }
    
    @MainActor
    func fetchListData() async throws {
        if let jsonString = Bundle.main.path(forResource: "CarouselList", ofType: "json"),
           let jsonData = try String(contentsOfFile: jsonString).data(using: .utf8) {
            carouselList = try await parser.dataParser(for: jsonData)
            filteredItems = carouselList?.carouselImages.first?.items ?? []
            makeFloaterItem()
        } else {
            throw ErrorHandler.fileNotAvailable
        }
    }
    
    func searchItems(for text: String) {
        if let carousel = carouselList?.carouselImages.first(where: { $0.id == selectedCarouselId }) {
            filteredItems = text.isEmpty ? carousel.items : carousel.items.filter { $0.title.lowercased().contains(text.lowercased()) }
        }
    }
   
    func getFloatItem() -> [String] {
        var items: [String] = []
        if let carousel = carouselList?.carouselImages.first(where: { $0.id == selectedCarouselId }) {
            items = carousel.items.map({$0.title})
        }
        return items
    }
    
    func makeFloaterItem() {
        if let carousel = carouselList?.carouselImages.first(where: { $0.id == selectedCarouselId }) {
            floaterItem = calculateStatistics(for: carousel)
        }
    }
    
    private func calculateStatistics(for carouselImage: CarouselImage) -> FloaterItem {
           var characterCount: [Character: Int] = [:]
           for item in carouselImage.items {
               for char in item.title.lowercased() {
                   if char.isLetter {
                       characterCount[char, default: 0] += 1
                   }
               }
           }
           let sortedCharacterCount = characterCount
               .map { CharacterCount(character: String($0.key), count: $0.value) }
               .sorted { $0.count > $1.count }
               .prefix(3)
           
           return FloaterItem(
               carouselId: carouselImage.id,
               page: "List \(carouselImage.id)",
               itemCount: carouselImage.items.count,
               topCharacters: Array(sortedCharacterCount)
           )
       }
}
