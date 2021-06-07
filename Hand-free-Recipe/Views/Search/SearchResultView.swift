//
//  SearchResultView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var viewModel: SearchViewModel

    init(viewModel: SearchViewModel, keyword: String) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    @StateObject static var viewModel = SearchViewModel()
    
    static var previews: some View {
        SearchResultView(viewModel: viewModel, keyword: "")
    }
}
