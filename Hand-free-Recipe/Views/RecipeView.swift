//
//  RecipeView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/5/31.
//

import SwiftUI

struct RecipeView: View {
    @State var isLike: Bool = false;
    @State var isFullScreenImage: Bool = false;
    @State var isPresented: Bool = false;
    
    @ObservedObject var imageLoader: ImageLoader
    @ObservedObject var moreRecipeLoader: SearchResultLoader

    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.imageLoader = ImageLoader(url: URL(string: recipe.coverImage)!, cache: Environment(\.imageCache).wrappedValue)
        self.moreRecipeLoader = SearchResultLoader(keyword: "", size: 8, categoryId: recipe.categoryIds.shuffled()[0])
    }

    var body: some View {
        ScrollView([.vertical], showsIndicators: true) {
            if moreRecipeLoader.results.isEmpty {
                ActivityIndicator(style: .circle(width: 5, duration: 0.9, size: 100))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            else {
                VStack {
                    GeometryReader { geometry in
                        VStack {
                            if geometry.frame(in: .global).minY <= 0 {
                                Image(uiImage: imageLoader.image ?? UIImage(named: "placeholder")!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                                    .onTapGesture {
                                        self.isFullScreenImage.toggle()
                                    }
                            } else {
                                Image(uiImage: imageLoader.image ?? UIImage(named: "placeholder")!)
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
                            Text(recipe.name)
                                .font(.largeTitle)
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            NavigationLink(destination: RecipePresentationView(recipeName: recipe.name, steps: recipe.steps)){
                                Text("卡片模式")
                                    .font(.title2)
                                    .accentColor(Color("Accent"))
                                    .padding()
                                    .border(Color.purple)
                                    .cornerRadius(3)
                            }
                        }

                        StraightLine()
                        
                        RecipeCookingDurationView(estimatedTime: recipe.estimatedTime)

                        RecipeDetailView(amount: recipe.yields, ingredients: recipe.ingredients)

                        StraightLine()
                            .padding(EdgeInsets(top: 18, leading: 0, bottom: 18, trailing: 0))

                        Text("步驟")
                            .font(.title)

                        ForEach(recipe.steps.indices) { step in
                            RecipeStepView(step: step + 1, description: recipe.steps[step].description, image: recipe.steps[step].image)
                                .padding(.top, 18)
                        }
                    }
                    .padding()
                }
                .background(Color("SecondaryView"))
                .padding(.bottom, 5)

                HStack {
                    Text("更多推薦")
                        .font(.title)
                    Spacer()
                }
                .padding()

                ScrollableStackRecipeView(recipes: moreRecipeLoader.results, showMore: false, isUnlimited: false)
                    .padding(.bottom, 10)
            }
        }
        .navigationBarHidden(false)
        .background(Color("MainView"))
        .toolbar(content: {
                    ToolBarContent(isLike: $isLike)})
        .edgesIgnoringSafeArea(.vertical)
        .onAppear {
            imageLoader.load()
            moreRecipeLoader.load()
        }
        .fullScreenCover(isPresented: $isFullScreenImage, content: {
            ImageFullScreenView(isFullScreenImage: $isFullScreenImage, image: imageLoader.image ?? UIImage(named: "placeholder")!)
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
            RecipeView(recipe: Recipe(categoryIds: [1], id: "0", name: "早餐", coverImage: "breakfast", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: Int.random(in: 2400..<190000), yields: 1))
                .preferredColorScheme(.light)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
