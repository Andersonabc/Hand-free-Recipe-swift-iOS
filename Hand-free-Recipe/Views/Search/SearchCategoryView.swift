//
//  SearchCategoryView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/4.
//

import SwiftUI

struct SearchCategoryView: View {
    @Binding var searchText: String
    @Binding var gotoSearchResultPage: Bool
    
    var body: some View {
        ScrollView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SearchCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCategoryView(searchText: .constant(""), gotoSearchResultPage: .constant(false))
    }
}
