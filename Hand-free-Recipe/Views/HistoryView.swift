//
//  HistoryView.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/5/31.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        NavigationView {

            RecipeCardView(recipe: Recipe(name: "早餐", coverImage: "breakfast", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: Int.random(in: 2400..<190000)))
        }
        .background(Color(.sRGB,
                          red: 36/255,
                          green: 37/255,
                          blue: 38/255))
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
