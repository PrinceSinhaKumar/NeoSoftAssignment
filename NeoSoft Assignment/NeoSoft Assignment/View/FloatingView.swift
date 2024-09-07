//
//  FloatingView.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 04/09/24.
//

import SwiftUI

struct FloatingView: View {
    let statistic: FloaterItem
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
               
                Text("List 1 (\(statistic.itemCount) items)")
                    .font(.headline)
                    .padding(.top)
                Text("Top 3 Occurrences:")
                    .padding(.top)
                ForEach(statistic.topCharacters, id: \.character) { characterCount in
                    Text("\(characterCount.character) = \(characterCount.count)")
                        .font(.body)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            
            Spacer()
        .cornerRadius(20)
        }
    }
}
