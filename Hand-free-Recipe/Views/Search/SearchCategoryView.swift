//
//  SearchCategoryView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/4.
//

import SwiftUI

struct SearchCategoryView: View {
    @StateObject private var categoryLoader: CategoryLoader = CategoryLoader(db_topic: "category", cache: Environment(\.imageCache).wrappedValue)

    @State var isLoading: Bool = false
    
    @Binding var searchText: String
    @Binding var gotoSearchResultPage: Bool
    
    var body: some View {
        Group {
            if isLoading {
                ActivityIndicator(style: .circle(width: 5, duration: 1, size: 90))
                    .foregroundColor(.primary)
            }
            else {
                ScrollView([.vertical], showsIndicators: false) {
                    HStack {
                        Text("食譜類別").font(.title2).bold()
                        Spacer()
                    }

                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(self.categoryLoader.categories) { category in
                            Button(action: {
                                searchText = category.name
                                gotoSearchResultPage = true
                            }, label: {
                                CategoryCardView(categoryName: category.name, image: categoryLoader.images[category.categoryId] ?? UIImage())
                            })
                            .animation(.linear(duration: 0.15))
                        }
                    }
                    .padding(.bottom, 10)
                    .animation(.interactiveSpring())
                }
            }
        }
        .onReceive(categoryLoader.objectWillChange, perform: { _ in
            if categoryLoader.dataIsFetched {
                DispatchQueue.main.async {
                    isLoading = false
                }
            }
        })
        .onAppear(perform: {
            categoryLoader.load()

            if !categoryLoader.dataIsFetched {
                DispatchQueue.main.async {
                    isLoading = true
                }
            }
        })
    }
}

struct SearchCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCategoryView(searchText: .constant(""), gotoSearchResultPage: .constant(false))
            .preferredColorScheme(.dark)
    }
}
