//
//  HomeView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/2.
//

import SwiftUI

struct HomeView: View {
    let BLD: [Recipe] = (0...10).map { _ in Recipe(name: "早餐", coverImage: "breakfast", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: Int.random(in: 2400..<190000)) }
    let new: [Recipe] =  (0...50).map { _ in Recipe(name: "早餐", coverImage: "example_food", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: Int.random(in: 2400..<190000)) }
    
    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            VStack {
                HStack {
                    Text("早餐推薦")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    // Optional: more recipes
                }.padding(.bottom, -5)
                ScrollableStackRecipeView(recipes: BLD, showMore: true, isUnlimited: false)
            }
            VStack {
                HStack {
                    Text("午餐推薦")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    // Optional: more recipes
                }.padding(.bottom, -5)
                ScrollableStackRecipeView(recipes: BLD, showMore: true, isUnlimited: false)
            }
            VStack {
                HStack {
                    Text("晚餐推薦")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    // Optional: more recipes
                }.padding(.bottom, -5)
                ScrollableStackRecipeView(recipes: BLD, showMore: true, isUnlimited: false)
            }
            VStack {
                HStack {
                    Text("最新推薦")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                LazyVGrid(columns: [GridItem(spacing: 10), GridItem()], alignment: .center, spacing: 15) {
                    ForEach(new.indices) { index in
                        RecipeCardView(recipe: new[index])
                    }
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        .background(Color(red: 36/255, green: 37/255, blue: 38/255))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
    }
}
