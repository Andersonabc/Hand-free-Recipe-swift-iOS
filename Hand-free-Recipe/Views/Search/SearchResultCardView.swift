//
//  SearchResultCardView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/21.
//

import SwiftUI

struct SearchResultCardView: View {
    @StateObject var imageLoader: ImageLoader
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: URL(string: recipe.coverImage)!, cache: Environment(\.imageCache).wrappedValue))
    }

    func description() -> String {
        var tmp: String = ""
        
        for item in recipe.ingredients {
            tmp += item.name + " "
        }

        return tmp
    }
    
    var body: some View {
        NavigationLink(destination: RecipeView()) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .bold()
                    DotLine().padding(.bottom, 8)
                    Text(self.description())
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                    Spacer()
                    Text("Cook Time: \(recipe.estimatedTime) min")
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("Servings: \(recipe.yields)")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding([.vertical, .leading])
                .padding(.trailing, 10)
                
                Image(uiImage: imageLoader.image ?? UIImage())
                    .resizable()
                    .frame(width: 200, height: 180)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            .background(Color("SecondaryView"))
        }
        .foregroundColor(.primary)
        .navigationBarHidden(true)
        .onAppear {
            self.imageLoader.load()
        }
    }
}

struct SearchResultCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchResultCardView(recipe: .init(id: "0", name: "Test", coverImage: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F9%2F2021%2F05%2F17%2Frajma-burgers-FT-RECIPE0621.jpg", ingredients: generateFakeIngredients(), steps: [], estimatedTime: 10, yields: 2))
        }
        .preferredColorScheme(.dark)
    }
}
