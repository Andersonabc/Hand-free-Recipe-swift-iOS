//
//  ImageFullScreenView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/2.
//

import SwiftUI

struct ImageFullScreenView: View {
    @Binding var isFullScreenImage: Bool
    let image: String

    // TODO: FullScreen
    var body: some View {
        VStack {
            Spacer()
            Image(image)
                .resizable()
                .scaledToFit()
            Spacer()
        }
        .background(Color(red: 0, green: 0, blue: 0, opacity: 1).ignoresSafeArea(.all))
        .onTapGesture {
            self.isFullScreenImage.toggle()
        }
    }
}

struct ImageFullScreenView_Previews: PreviewProvider {
    @State static var isFullScreenView: Bool = false
    
    static var previews: some View {
        ImageFullScreenView(isFullScreenImage: $isFullScreenView, image: "example_food")
    }
}
