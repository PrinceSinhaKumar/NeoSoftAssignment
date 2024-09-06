//
//  FloatingButton.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 07/09/24.
//

import SwiftUI

struct FloatingButton: View {
    @Binding var showSheet: Bool
    var body: some View {
        Button(action: {
            showSheet.toggle()
        }) {
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
