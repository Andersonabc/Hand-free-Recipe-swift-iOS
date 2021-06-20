//
//  HistoryRecipeView.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/6/12.
//

import SwiftUI

struct HistoryRecipeView: View {
    @State private var isFavorite: Bool = false;
    @State private var tap: Bool = false;
    
    let recipe: Recipe
    let imageMaxW: CGFloat
    let imageMaxH: CGFloat
    let fontAccent: Color
    
    init(recipe: Recipe,
         imageMaxW: CGFloat = 150,
         imageMaxH: CGFloat = 150,
         fontAccent: Color = Color("Accent")) {
        self.recipe = recipe
        self.imageMaxW = imageMaxW
        self.imageMaxH = imageMaxH
        self.fontAccent = fontAccent
    }
    
    var body: some View {
        NavigationLink(destination: RecipeView()) {
            HStack(alignment: .center, spacing: 0) {
                VStack {
                    Text(recipe.name)
                        .font(.title)
                        .fontWeight(.medium)
                        .accentColor(self.fontAccent)
                        .lineLimit(1)
                    
                    Text(Date(), style: .time)
                        .font(.headline)
                        .fontWeight(.light)
                        .accentColor(self.fontAccent)
                        .lineLimit(1)
                }
                .frame(width: self.imageMaxW,
                       alignment: .center)
                .padding()
                
                Image(recipe.coverImage)
                    .resizable()
                    .frame(width: imageMaxW,
                           height: imageMaxH)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
            .background(Color("SecondaryView"))
            .frame(maxWidth: self.imageMaxW * 2,
                   maxHeight: self.imageMaxH)
            .cornerRadius(10)
            .shadow(radius: 0)
            .aspectRatio(1, contentMode: .fill)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB,
                                  red: 150/255,
                                  green: 150/255,
                                  blue: 150/255,
                                  opacity: 0.1),
                            lineWidth: 0)
            )
        }
    }
}

struct HistoryRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRecipeView(recipe: Recipe(name: "早餐", coverImage: "breakfast", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: 2000, yields: 1))
            .preferredColorScheme(.dark)
    }
}
