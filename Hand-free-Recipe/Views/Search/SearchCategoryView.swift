//
//  SearchCategoryView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/4.
//

import SwiftUI

struct SearchCategoryView: View {
    let images: [String] = ["pasta", "fish", "hamburger", "spaghetti"]
    let names: [String] = ["義式料理", "魚類料理", "美式速食", "義大利麵"]
    @Binding var searchText: String
    @Binding var gotoSearchResultPage: Bool
    
    @State private var tap: Bool = false;
    
    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            HStack {
                Text("食譜類別").font(.title2).bold()
                Spacer()
            }

            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(names.indices) { index in
                    Button(action: {
                        searchText = names[index]
                        gotoSearchResultPage = true
                    }, label: {
                        CategoryCardView(categoryImage: images[index], categoryName: names[index])
                    })
                    .animation(.linear(duration: 0.15))
                }
            }
            .animation(.interactiveSpring())
        }
    }
}

struct SearchCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCategoryView(searchText: .constant(""), gotoSearchResultPage: .constant(false))
    }
}
