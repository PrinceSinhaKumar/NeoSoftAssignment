//
//  CarouselUIKitView.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 07/09/24.
//

import SwiftUI

struct UIKitScreen: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CarouselViewController {
        return CarouselViewController()
    }
    
    func updateUIViewController(_ uiViewController: CarouselViewController, context: Context) {
        // Perform any updates on the UIKit view controller if needed
    }
}

struct CarouselUIKitView: View {
    var body: some View {
        VStack {
            UIKitScreen()
                .ignoresSafeArea()
        }
    }
}
#Preview {
    CarouselUIKitView()
}


