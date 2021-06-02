//
//  RecipeView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/5/31.
//

import SwiftUI

// TODO: send recipes
struct RecipeView: View {
    @Environment(\.colorScheme) var colorScheme

    @State var isLike: Bool = false;
    @State var isFullScreenImage: Bool = false;
    @State var isPresented: Bool = false;
    @State var uiNavigationController: UINavigationController?
    
    let example_recipe: Recipe = Recipe(name: "炭烤透抽", coverImage: "example_food", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: 42000)

    var body: some View {
        ScrollView([.vertical], showsIndicators: true) {
            VStack {
                GeometryReader { geometry in
                    VStack {
                        if geometry.frame(in: .global).minY <= 0 {
                            Image(example_recipe.coverImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .onTapGesture {
                                    self.isFullScreenImage.toggle()
                                }
                        } else {
                            Image(example_recipe.coverImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                                .clipped()
                                .offset(y: -geometry.frame(in: .global).minY)
                        }
                    }
                }
                .frame(height: 400)
                VStack(alignment: .leading) {
                    HStack {
                        Text(example_recipe.name)
                            .font(.largeTitle)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: RecipePresentationView(recipeName: example_recipe.name, steps: example_recipe.steps)){
                            Text("卡片模式")
                                .font(.title2)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .padding()
                                .border(Color.purple)
                                .cornerRadius(3)
                        }
                    }
                    
                    StraightLine()
                    
                    RecipeCookingDurationView(estimatedTime: example_recipe.estimatedTime)

                    RecipeDetailView(amount: "", ingredients: example_recipe.ingredients);
                    
                    StraightLine()
                        .padding(EdgeInsets(top: 18, leading: 0, bottom: 18, trailing: 0))
                    
                    Text("步驟")
                        .font(.title)

                    ForEach(example_recipe.steps.indices) { step in
                        RecipeStepView(step: step + 1, description: example_recipe.steps[step].description, image: example_recipe.steps[step].image)
                            .padding(.top, 18)
                    }
                }
                .padding()
            }
            .background(Color(red: 36/255, green: 37/255, blue: 38/255))
            .padding(.bottom, 5)

            HStack {
                Text("更多推薦")
                    .font(.title)
                Spacer()
            }
            .padding()

            ScrollableStackRecipeView(recipes: (0...10).map { _ in Recipe(name: "早餐", coverImage: "breakfast", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: Int.random(in: 2400..<190000)) }, showMore: false, isUnlimited: false)
                .padding(.bottom, 15)
        }
        .toolbar(content: {
                    ToolBarContent(isLike: $isLike)})
        .edgesIgnoringSafeArea(.top)
        .fullScreenCover(isPresented: $isFullScreenImage, content: {
            ImageFullScreenView(isFullScreenImage: $isFullScreenImage, image: example_recipe.coverImage)
        })
    }
}

struct ToolBarContent: ToolbarContent {
    @Binding var isLike: Bool
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button(action: {
                    self.isLike.toggle()
                }, label: {
                    Image(systemName: "heart\(self.isLike ? ".fill" : "")")
                        .font(.title)
                        .frame(height: 44)
                        .padding(.trailing, 5)
                        .padding(.leading, 5)
                })
                .help(Text("Share recipe"))
                // for adjusting image size
                Spacer(minLength: 0)
            }
            .foregroundColor(.red)
        }


        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button(action: {
                    // TODO: do sharing
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                        .imageScale(.large)
                        .frame(height: 44, alignment: .center)
                        .padding(.trailing, 5)
                        .padding(.leading, 5)
                })
                .help(Text("Share recipe"))
                // for adjusting image size
                Spacer(minLength: 0)
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            RecipeView()
                .preferredColorScheme(.dark)
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
}
