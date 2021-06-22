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
    @ObservedObject var imageLoader: ImageLoader
    
    init(step: Int, description: String, image: String?) {
        self.step = step
        self.description = description
        self.image = image
        self.imageLoader = ImageLoader(url: URL(string: image != nil ? image! : "http://test.com")!, cache: Environment(\.imageCache).wrappedValue)
    }

    var body: some View {
        VStack {
            HStack {
                Label(
                    title: { Text(description) },
                    icon: { Image(systemName: "\(step).circle.fill").imageScale(.large) }
                )
                Spacer()
            }
            if image != nil {
                HStack {
                    Spacer()
                    Image(uiImage: imageLoader.image ?? UIImage(named: "placeholder")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.85)
                        .cornerRadius(4.0)
                        .onTapGesture {
                            self.isFullScreenView.toggle()
                        }
                }
                .fullScreenCover(isPresented: $isFullScreenView, content: {
                    ImageFullScreenView(isFullScreenImage: $isFullScreenView, image: imageLoader.image ?? UIImage(named: "placeholder")!)
                })
            }
        }
        .onAppear {
            if image != nil {
                imageLoader.load()
            }
        }
    }
}

struct RecipeStepView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepView(step: 1, description: "Test 123", image: nil)
    }
}
