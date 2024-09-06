//
//  CarouselListModel.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 03/09/24.
//

import Foundation

struct CarouselListModel: Decodable {
    let carouselImages: [CarouselImage]
}

struct CarouselImage: Identifiable, Decodable {
    let id: Int
    let imageUrl: String
    let description: String
    let items: [ListItem]
}

struct ListItem: Identifiable, Decodable, Equatable {
    var imageUrl: String
    let id: Int
    let title: String
    let subTitle: String
}

struct FloaterItem {
    let carouselId: Int
    let page: String
    let itemCount: Int
    let topCharacters: [CharacterCount]
}

struct CharacterCount {
    let character: String
    let count: Int
}
