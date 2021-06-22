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
    let keyword: String
    
    init(recipes: [Recipe], showMore: Bool, isUnlimited: Bool) {
        self.recipes = recipes
        self.showMore = showMore
        self.isUnlimited = isUnlimited
        self.keyword = ""
    }
    
    init(recipes: [Recipe], showMore: Bool, isUnlimited: Bool, keyword: String) {
        self.recipes = recipes
        self.showMore = showMore
        self.isUnlimited = isUnlimited
        self.keyword = keyword
    }

    var body: some View {
        ScrollView([.horizontal], showsIndicators: false) {
            if isUnlimited {
                LazyHStack {
                    ForEach(recipes, id: \.self) { recipe in
                        RecipeCardView(recipe: recipe)
                    }

                    if showMore {
                        NavigationLink(
                            destination: SearchView(searchedText: keyword, inSearchResultPage: true)) {
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
                    ForEach(recipes, id: \.self) { recipe in
                        RecipeCardView(recipe: recipe).padding([.horizontal])
                    }

                    if showMore {
                        NavigationLink(
                            destination: SearchView(searchedText: keyword, inSearchResultPage: true)) {
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
        ScrollableStackRecipeView(recipes: (0...10).map { _ in Recipe(categoryIds: [1], id: "0", name: "早餐", coverImage: "breakfast", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: Int.random(in: 2400..<190000), yields: 1) }, showMore: true, isUnlimited: false)
            .preferredColorScheme(.light)
    }
}
