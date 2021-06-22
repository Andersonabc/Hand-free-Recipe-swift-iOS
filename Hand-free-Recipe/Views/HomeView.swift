//
//  HomeView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/2.
//

import SwiftUI

struct HomeView: View {
    @StateObject var breakfast = SearchResultLoader(keyword: "breakfast", size: 5)
    @StateObject var lunch = SearchResultLoader(keyword: "lunch", size: 5)
    @StateObject var dinner = SearchResultLoader(keyword: "dinner", size: 5)
    @StateObject var new = SearchResultLoader(keyword: "", size: 10)
    
    @State var loadOnce = false
    @State var page = 0
    let size = 10

    var body: some View {
        Group {
            if breakfast.results.isEmpty || lunch.results.isEmpty || dinner.results.isEmpty || new.results.isEmpty {
                ActivityIndicator(style: .circle(width: 5, duration: 0.9, size: 100))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            else {
                ScrollView([.vertical], showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Breakfast Recommendation")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            Spacer()
                            // Optional: more recipes
                        }.padding(.bottom, -5)
                        ScrollableStackRecipeView(recipes: breakfast.results, showMore: true, isUnlimited: false, keyword: "Breakfast")
                    }
                    VStack {
                        HStack {
                            Text("Lunch Recommendation")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            Spacer()
                            // Optional: more recipes
                        }.padding(.bottom, -5)
                        ScrollableStackRecipeView(recipes: lunch.results, showMore: true, isUnlimited: false, keyword: "Lunch")
                    }
                    VStack {
                        HStack {
                            Text("Dinner Recommendation")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            Spacer()
                            // Optional: more recipes
                        }.padding(.bottom, -5)
                        ScrollableStackRecipeView(recipes: dinner.results, showMore: true, isUnlimited: false, keyword: "Dinner")
                    }
                    VStack {
                        HStack {
                            Text("Newest Recipe Recommendation")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            Spacer()
                        }
                        LazyVGrid(columns: [GridItem(spacing: 10), GridItem()], alignment: .center, spacing: 15) {
                            ForEach(new.results, id: \.self) { recipe in
                                RecipeCardView(recipe: recipe)
                            }
                        }
                        .padding([.horizontal])

                        if !new.isLastPage {
                            if new.results.count == (page+1) * size {
                                Button(action: {
                                    page += 1
                                    new.next()
                                }, label: {
                                    Text("More...?")
                                        .foregroundColor(.primary)
                                        .font(.title2)
                                        .frame(width: 200, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 18))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(Color.secondary, lineWidth: 1)
                                        )
                                        .padding()
                                })
                            }
                            else {
                                ActivityIndicator(style: .circle(width: 3, duration: 0.8, size: 40))
                                    .padding(.vertical, 10)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if !self.loadOnce {
                breakfast.load()
                lunch.load()
                dinner.load()
                new.load()
                
                self.loadOnce = true
            }
        }
        .navigationBarHidden(true)
        .background(Color("MainView").ignoresSafeArea())
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
