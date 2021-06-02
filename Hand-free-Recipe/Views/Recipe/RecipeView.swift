//
//  RecipeView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/5/31.
//

import SwiftUI
import LoremSwiftum

func generateFakeIngredients() -> [Ingredients] {
    var tmp = [Ingredients]()

    let nested = IngredientGroup(name: "烤肉醬")

    for _ in 0...3 {
        tmp.append(Ingredient(name: "透抽 10斤"))
        nested.add(ingredient: Ingredient(name: "透抽 10斤"))
    }
    
    tmp.append(nested)
    tmp.append(nested)

    return tmp
}

func generateDesciptions() -> [String] {
    var tmp = [String]()
    
    for _ in 0...6 {
        tmp.append(Lorem.sentences(2))
    }

    return tmp
}

func generateImages() -> [String] {
    var tmp = [String]()
    
    for _ in 0...6 {
        tmp.append("example_food")
    }

    return tmp
}

struct RecipeView: View {
    @Environment(\.colorScheme) var colorScheme

    @State var isLike: Bool = false;
    @State var isFullScreenImage: Bool = false;
    @State var isPresented: Bool = false;
    @State var uiNavigationController: UINavigationController?
    let recipeImageCover: String = "example_food"
    let recipeName: String = "炭烤透抽"
    let cookingDuration: String = "2 小時 10 分鐘"
    let stepsDescriptions: [String] = generateDesciptions()
    let stepsImages: [String] = generateImages()

    let ingredients: [Ingredients] = generateFakeIngredients()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                GeometryReader { geometry in
                    VStack {
                        if geometry.frame(in: .global).minY <= 0 {
                            Image(recipeImageCover)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .onTapGesture {
                                    self.isFullScreenImage.toggle()
                                }
                        } else {
                            Image(recipeImageCover)
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
                        Text(recipeName)
                            .font(.largeTitle)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: RecipePresentationView(recipeName: recipeName, descriptions: stepsDescriptions, imageURLs: stepsImages)){
                            Text("卡片模式")
                                .font(.title2)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .padding()
                                .border(Color.purple)
                                .cornerRadius(3)
                        }
                    }
                    
                    StraightLine()
                    
                    RecipeCookingDurationView(cookingDuration: self.cookingDuration)
                    
                    RecipeDetailView(amount: "", ingredients: ingredients);
                    
                    StraightLine()
                        .padding(EdgeInsets(top: 18, leading: 0, bottom: 18, trailing: 0))
                    
                    Text("步驟")
                        .font(.title)

                    ForEach(stepsDescriptions.indices) { step in
                        RecipeStepView(step: step + 1, description: stepsDescriptions[step], imageURL: stepsImages[step])
                            .padding(.top, 18)
                    }
                }
                .padding()
            }
            .background(Color(red: 36/255, green: 37/255, blue: 38/255).edgesIgnoringSafeArea(.all))
            .padding(.bottom, 5)

            HStack {
                Text("更多推薦")
                    .font(.title)
                Spacer()
            }
            .padding(EdgeInsets(top: 18, leading: 0, bottom: 18, trailing: 0))
        }
        .toolbar(content: {
                    ToolBarContent(isLike: $isLike)})
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $isFullScreenImage, content: {
            ImageFullScreenView(isFullScreenImage: $isFullScreenImage, imageURL: recipeImageCover)
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

    }
}
