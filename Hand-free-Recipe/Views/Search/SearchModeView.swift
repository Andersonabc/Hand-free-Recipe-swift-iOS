//
//  SearchModeView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/20.
//

import SwiftUI

struct SearchModeView: View {
    @StateObject var searchService: SearchService = SearchService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var gotoSearchResultPage: Bool
    
    @Binding var searchText: String

    let inSearchResultPage: Bool
    let searchedText: String
    let searchHistoryHandler = SearchHistoryHandler.shared
    

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // endEditing should be put in the first update
                    // because of using UIResponder.resignFirstResponder
                    UIApplication.shared.endEditing()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.bold(.title2)())
                }.padding(.leading)
                SearchBar(searchService: searchService, searchText: $searchText, gotoSearchResultPage: $gotoSearchResultPage, searchedText: searchedText, searchHistoryHandler: searchHistoryHandler)
                    .padding()
            }
            .background(Color(red: 20/255, green: 20/255, blue: 20/255).edgesIgnoringSafeArea(.vertical))

            SearchHistoryView(searchService: searchService, searchText: $searchText, gotoSearchResultPage: $gotoSearchResultPage, searchedText: searchedText, searchHistoryHandler: searchHistoryHandler)
        }
        .background(Color(red: 20/255, green: 20/255, blue: 20/255).edgesIgnoringSafeArea(.vertical))
        .navigationBarHidden(true)
    }
}

//struct SearchModeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchModeView()
//    }
//}
