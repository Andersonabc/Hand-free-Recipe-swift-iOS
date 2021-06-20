//
//  FavoriteView.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/6/2.
//

import SwiftUI

struct FavoriteView: View {
    
    let new: [Recipe] =  (0...50).map { _ in Recipe(name: "早餐",
                                                    coverImage: "example_food",
                                                    ingredients: generateFakeIngredients(),
                                                    steps: generateFakeSteps(),
                                                    estimatedTime: Int.random(in: 2400..<190000), yields: 1) }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            let columns = [
                GridItem(.flexible(),
                         spacing: 10),
                GridItem()
            ]
            LazyVGrid(columns: columns,
                      spacing: 10) {
                ForEach(new.indices) { index in
                    RecipeCardView(recipe: new[index])
                }
            }
            .padding()
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .preferredColorScheme(.dark)
    }
}
