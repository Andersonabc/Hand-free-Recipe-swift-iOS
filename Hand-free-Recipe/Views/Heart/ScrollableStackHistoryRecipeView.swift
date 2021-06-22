//
//  ScrollableStackHistoryRecipeView.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/6/13.
//

import SwiftUI

struct ScrollableStackHistoryRecipeView: View {
    let recipes: [Recipe]
    let showMore: Bool
    let isUnlimited: Bool
    
    var body: some View {
        ScrollView([.horizontal], showsIndicators: false) {
            if isUnlimited {
                LazyHStack {
                    ForEach(recipes.indices) { index in
                        HistoryRecipeView(recipe: recipes[index])
                    }

                    if showMore {
                        NavigationLink(
                            destination: Text("Destination")) {
                            ZStack {
                                Image(systemName: "arrow.right")
                                    .font(.title)
                                    .foregroundColor(.primary)
                                Circle()
                                    .stroke(Color.secondary, lineWidth: 2)
                            }
                        }
                        .frame(width: 65, height: 60)
                        .padding()
                    }
                }
            }
            else {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(recipes.indices) { index in
                        HistoryRecipeView(recipe: recipes[index])
                            .padding([.horizontal])
                    }

                    if showMore {
                        NavigationLink(
                            destination: Text("Destination")) {
                            ZStack {
                                Image(systemName: "arrow.right")
                                    .font(.title)
                                    .foregroundColor(.primary)
                                Circle()
                                    .stroke(Color.secondary, lineWidth: 2)
                                    
                            }
                        }
                        .frame(width: 65, height: 60)
                        .padding()
                    }
                }
            }
        }
        .frame(height: 150)
    }
}

struct ScrollableStackHistoryRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableStackHistoryRecipeView(recipes: (0...10).map { _ in Recipe(categoryIds: [1], id: "0", name: "早餐", coverImage: "breakfast", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: Int.random(in: 2400..<190000), yields: 1) }, showMore: true, isUnlimited: false)
            .preferredColorScheme(.dark)
    }
}
