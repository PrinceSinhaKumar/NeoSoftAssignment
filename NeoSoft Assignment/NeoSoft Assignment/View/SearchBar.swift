//
//  SearchBar.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 07/09/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var body: some View {
        TextField("Search",
                  text: $searchText)
        
        .padding([.leading,.trailing], 10)
        .frame(height: 30)
        .background(Color.searchbarBackground)
        .cornerRadius(8)
        .padding(.horizontal, 30)
    }
}
