//
//  SearchView.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/2.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()

    @State var searchText = ""
    let searchedText: String

    // independant value
    @State var gotoSearchResultPage: Bool = false
    @State var enterSearchStatus: Bool = false
    
    // shared by value between search pages
    let inSearchResultPage: Bool

    var body: some View {
        VStack(spacing: 0) {
            // go to search result page
            NavigationLink(destination: SearchView(viewModel: viewModel, searchedText: searchText, inSearchResultPage: true), isActive: $gotoSearchResultPage) {
                    EmptyView()
                }

            SearchBar(enterSearchStatus: $enterSearchStatus, searchText: $searchText, gotoSearchResultPage: $gotoSearchResultPage, searchedText: searchedText, inSearchResultPage: inSearchResultPage)

            VStack {
                if enterSearchStatus {
                    SearchHistoryView(viewModel: viewModel, searchText: $searchText, gotoSearchResultPage: $gotoSearchResultPage)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                }
                else if inSearchResultPage {
                    SearchResultView(viewModel: viewModel, keyword: searchedText)
                }
                else {
                    SearchCategoryView(searchText: $searchText,  gotoSearchResultPage: $gotoSearchResultPage)
                }
            }.padding()
        }
        .navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    @StateObject static var viewModel = SearchViewModel()
    
    static var previews: some View {
        NavigationView {
            SearchView(viewModel: viewModel, searchedText: "", inSearchResultPage: false)
        }.preferredColorScheme(.dark)
    }
}
