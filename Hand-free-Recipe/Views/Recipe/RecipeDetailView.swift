//
//  RecipeDetailView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/1.
//

import SwiftUI

// TODO: Need to refactor

struct RecipeDetailView: View {
    let amount: Int
    let ingredients: [Ingredients]

    var body: some View {
        VStack {
            HStack {
                Text("預備食材")
                    .font(.title)
                Spacer()
            }
            HStack {
                Label(
                    title: { Text("\(amount)") },
                    icon: { Image(systemName: "person") }
                )
                Spacer()
            }
        }
        .padding(.bottom, 10)

        VStack(alignment: .leading) {
            ForEach(ingredients.indices) { i in
                if ingredients[i].isComposite() {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(ingredients[i].name)
                        StraightLine()
                        if let children = ingredients[i].children {
                            ForEach(children.indices) { j in
                                Text(children[j].name)
                                if j != children.count - 1 {
                                    DotLine()
                                }
                            }
                        }
                    }
                    .padding(.top, 10)
                }
                else {
                    Text(ingredients[i].name)
                    if i != ingredients.count - 1 {
                        DotLine()
                    }
                }
            }
        }

    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RecipeDetailView(amount: 1, ingredients: [])
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}
