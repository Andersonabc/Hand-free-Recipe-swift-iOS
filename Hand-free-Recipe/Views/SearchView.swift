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
    @ObservedObject var viewModel: SearchViewModel

    @State var searchText = ""
    let searchedText: String

    // independant value
    @State var gotoSearchResultPage: Bool = false
    @State var enterSearchStatus: Bool = false
    
    // shared by value between search pages
    let inSearchResultPage: Bool

    var body: some View {
        VStack {
            // go to search result page
            NavigationLink(destination: SearchView(viewModel: viewModel, searchedText: searchText, inSearchResultPage: true), isActive: $gotoSearchResultPage) {
                    EmptyView()
                }

            SearchBar(enterSearchStatus: $enterSearchStatus, searchText: $searchText, gotoSearchResultPage: $gotoSearchResultPage, searchedText: searchedText, inSearchResultPage: inSearchResultPage)

            if enterSearchStatus {
                SearchHistoryView(records: $viewModel.historyRecords)
                    .onAppear(perform: {
                        viewModel.fetchHistory()
                    })
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
            }
            else if inSearchResultPage {
                SearchResultView(searchedText: searchText)
            }
            else {
                SearchCategoryView(searchText: $searchText,  gotoSearchResultPage: $gotoSearchResultPage)
            }
        }.navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    @StateObject static var viewModel = SearchViewModel()
    
    static var previews: some View {
        NavigationView {
            SearchView(viewModel: viewModel, searchedText: "", inSearchResultPage: false)
        }
    }
}
