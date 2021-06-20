//
//  SearchBar.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/2.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var searchService: SearchService
    @Binding var searchText: String
    @Binding var gotoSearchResultPage: Bool
    @State var text: String = ""

    let searchedText: String
    let searchHistoryHandler: SearchHistoryHandler

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(Font.system(size: 18, weight: .light))
                .foregroundColor(.primary)
                .padding(.leading, 10)
            ZStack(alignment: .leading) {
                if searchService.keyword.isEmpty {
                    if !searchedText.isEmpty {
                        Text(searchedText).foregroundColor(.primary)
                    }
                    else {
                        Text("輸入食譜類別、食譜名稱...").foregroundColor(Color.init(.sRGB, white: 1, opacity: 0.6))
                    }
                }
                TextField("", text: $searchService.keyword) { _ in
                    
                } onCommit: {
                    if searchService.keyword != searchedText {
                        searchText = searchService.keyword
                        gotoSearchResultPage = true
                        searchHistoryHandler.addHistory(keyword: searchService.keyword)
                    }
                }
                .contentShape(Rectangle())
            }
        }
        .frame(height: 45)
        .background(Color(.sRGB, red: 61/255, green: 61/255, blue: 61/255, opacity: 0.6))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.secondary, lineWidth: 1)
        )
        .onAppear(perform: {
            DispatchQueue.main.async {
                searchService.keyword = searchedText
            }
        })
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//        }
//        .preferredColorScheme(.dark)
//    }
//}
