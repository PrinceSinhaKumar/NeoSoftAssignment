//
//  ListView.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 04/09/24.
//

import SwiftUI

struct ListView: View {
    let filterItem: [ListItem]
    var body: some View {
        ForEach(filterItem) { item in
            HStack {
                Image(item.imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                VStack(alignment: .leading, spacing: 5){
                    Text(item.title)
                        .font(.system(size: 15, weight: .semibold))
                    Text(item.subTitle)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color.secondary)
                }
                Spacer()
            }
            .background(Color.listBackground)
            .cornerRadius(10)
            
        }
    }
}
