//
//  HistoryView.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/5/31.
//

import SwiftUI

struct HistoryView: View {
    
    let BLD: [Recipe] = (0...10).map { _ in Recipe(name: "早餐",
                                                   coverImage: "breakfast",
                                                   ingredients: generateFakeIngredients(),
                                                   steps: generateFakeSteps(),
                                                   estimatedTime: Int.random(in: 2400..<190000)) }
    
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: true) {
            VStack {
                HStack {
                    Text(Date(), style: .date)
                        .font(.title)
                        .bold()
                        .padding()
                    Spacer()
                }
                ScrollableStackHistoryRecipeView(recipes: BLD,
                                                 showMore: false,
                                                 isUnlimited: false)
            }
            VStack {
                HStack {
                    Text(Date(), style: .date)
                        .font(.title)
                        .bold()
                        .padding()
                    Spacer()
                }
                ScrollableStackHistoryRecipeView(recipes: BLD,
                                                 showMore: false,
                                                 isUnlimited: false)
            }
            VStack {
                HStack {
                    Text(Date(), style: .date)
                        .font(.title)
                        .bold()
                        .padding()
                    Spacer()
                }
                ScrollableStackHistoryRecipeView(recipes: BLD,
                                                 showMore: false,
                                                 isUnlimited: false)
            }
            
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .preferredColorScheme(.dark)
    }
}
