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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var searchText = ""
    let searchedText: String

    // independant value
    @State var gotoSearchResultPage: Bool = false

    // shared by value between search pages
    let inSearchResultPage: Bool

    var body: some View {
        VStack(spacing: 0) {
            // go to search result page
            NavigationLink(destination: SearchView(searchedText: searchText, inSearchResultPage: true), isActive: $gotoSearchResultPage) {
                    EmptyView()
                }

            HStack {
                if inSearchResultPage {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                    .padding(.horizontal)
                }

                NavigationLink(destination: SearchModeView(gotoSearchResultPage: $gotoSearchResultPage, searchText: $searchText, inSearchResultPage: inSearchResultPage, searchedText: searchedText)) {
                    SearchBar(searchService: SearchService(), searchText: .constant(""), gotoSearchResultPage: .constant(false), searchedText: searchedText, searchHistoryHandler: SearchHistoryHandler.shared)
                        .padding([.vertical, inSearchResultPage ? .trailing : .horizontal])
                }
            }

            VStack {
                if inSearchResultPage {
                    SearchResultView(keyword: searchedText, size: 10)
                }
                else {
                    SearchCategoryView(searchText: $searchText, gotoSearchResultPage: $gotoSearchResultPage)
                }
            }.padding(.horizontal)
            .frame(maxHeight: .infinity)
        }
        .navigationBarHidden(true)
        .background(Color("MainView").ignoresSafeArea())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView(searchedText: "", inSearchResultPage: false)
        }.preferredColorScheme(.dark)
    }
}
