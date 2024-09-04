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

struct ListItem: Identifiable, Decodable {
    var imageUrl: String
    let id: Int
    let title: String
    let subTitle: String
}

