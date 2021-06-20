//
//  ScrollableStackRecipeView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/2.
//

import SwiftUI

struct ScrollableStackRecipeView: View {
    let recipes: [Recipe]
    let showMore: Bool
    let isUnlimited: Bool

    var body: some View {
        ScrollView([.horizontal], showsIndicators: false) {
            if isUnlimited {
                LazyHStack {
                    ForEach(recipes.indices) { index in
                        RecipeCardView(recipe: recipes[index])
                    }

                    if showMore {
                        NavigationLink(
                            destination: Text("Destination")) {
                            ZStack {
                                Image(systemName: "arrow.right")
                                    .font(.title)
                                    .foregroundColor(Color("Accent"))
                                Circle()
                                    .stroke(Color("Accent").opacity(0.5), lineWidth: 2)
                                    
                            }
                        }
                        .frame(width: 65, height: 60)
                        .padding()
                    }
                }
                .frame(height: 380)
            }
            else {
                HStack {
                    ForEach(recipes.indices) { index in
                        RecipeCardView(recipe: recipes[index]).padding([.horizontal])
                    }

                    if showMore {
                        NavigationLink(
                            destination: Text("Destination")) {
                            ZStack {
                                Image(systemName: "arrow.right")
                                    .font(.title)
                                    .foregroundColor(Color("Accent"))
                                Circle()
                                    .stroke(Color("Accent").opacity(0.5), lineWidth: 2)
                                    
                            }
                        }
                        .frame(width: 65, height: 60)
                        .padding()
                    }
                }
                .frame(height: 380)
            }
        }
    }
}

struct ScrollableStackRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableStackRecipeView(recipes: (0...10).map { _ in Recipe(name: "早餐", coverImage: "breakfast", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: Int.random(in: 2400..<190000), yields: 1) }, showMore: true, isUnlimited: false)
            .preferredColorScheme(.light)
    }
}
