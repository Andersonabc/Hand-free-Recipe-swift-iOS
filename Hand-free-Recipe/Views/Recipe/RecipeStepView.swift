//
//  RecipeStepView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/2.
//

import SwiftUI

struct RecipeStepView: View {
    let step: Int
    let description: String
    let image: String?
    @State var isFullScreenView: Bool = false

    var body: some View {
        VStack {
            HStack {
                Label(
                    title: { Text(description) },
                    icon: { Image(systemName: "\(step).circle.fill").imageScale(.large) }
                )
                Spacer()
            }
            if let image = image {
                HStack {
                    Spacer()
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.85)
                        .cornerRadius(4.0)
                        .onTapGesture {
                            self.isFullScreenView.toggle()
                        }
                }
                .fullScreenCover(isPresented: $isFullScreenView, content: {
                    ImageFullScreenView(isFullScreenImage: $isFullScreenView, image: image)
                })
            }
        }
    }
}

struct RecipeStepView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepView(step: 1, description: "Test 123", image: nil)
    }
}
