//
//  CardView.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/5/31.
//

import SwiftUI


// TODO: Make text more flexible
struct RecipeCardView: View {
    @State private var isFavorite: Bool = false;
    @State private var tap: Bool = false;
    let recipe: Recipe
    
    var body: some View {
        NavigationLink(destination: RecipeView()) {
            VStack {
                Image(recipe.coverImage)
                    .resizable()
                    .frame(maxWidth: 300, maxHeight: 300)
                    .aspectRatio(contentMode: .fill)
                    .clipped()

                HStack {
                    Text(recipe.name)
                        .font(.title)
                        .fontWeight(.medium)
                        .accentColor(Color("Accent"))
                        .lineLimit(1)

                    Spacer(minLength: 35) // Need to fix...
                }
                .layoutPriority(100)
                .padding()

            }
            .background(Color("SecondaryView"))
            .frame(maxWidth: 300, maxHeight: 370)
            .cornerRadius(10)
            .shadow(radius: 10)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1))
        }
        .overlay(
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 21, height: 21)
                    .foregroundColor(.red)
                    .offset(x: -35, y: -20)
                    .onTapGesture {
                        tap = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            tap = false
                        }
                        isFavorite.toggle()
                    }.scaleEffect((tap ? 1.4 : 1))
                .animation(.spring(response: 0.2, dampingFraction: 1)),
        alignment: .bottomTrailing)
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: Recipe(name: "早餐", coverImage: "breakfast", ingredients: generateFakeIngredients(), steps: generateFakeSteps(), estimatedTime: 2000, yields: 1))
            .preferredColorScheme(.light)
    }
}
