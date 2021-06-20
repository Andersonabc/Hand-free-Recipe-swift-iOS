//
//  SearchHistoryView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import SwiftUI

struct SearchHistoryView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)])
    private var records: FetchedResults<SearchHistory>

    @ObservedObject var searchService: SearchService

    @Binding var searchText: String
    @Binding var gotoSearchResultPage: Bool
    
    let searchedText: String

    let searchHistoryHandler: SearchHistoryHandler

    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            if !searchService.keyword.isEmpty {
                ForEach(searchService.historyResults, id: \.self) { record in
                    HStack {
                        Button(action: {
                            searchHistoryHandler.addHistory(keyword: record.keyword!)
                            if searchedText != record.keyword! {
                                searchText = record.keyword!
                                gotoSearchResultPage = true
                            }
                        }, label: {
                            History(text: record.keyword!)
                        })
                    }.padding()
                }
                ForEach(searchService.searchResults, id: \.self) { result in
                    HStack {
                        Button(action: {
                            searchHistoryHandler.addHistory(keyword: result)
                            if searchedText != result {
                                searchText = result
                                gotoSearchResultPage = true
                            }
                        }, label: {
                            SearchResult(text: result)
                        })
                    }.padding()
                }
            }
            else {
                ForEach(records) { record in
                    HStack {
                        Button(action: {
                            searchHistoryHandler.addHistory(keyword: record.keyword!)
                            if searchedText != record.keyword! {
                                searchText = record.keyword!
                                gotoSearchResultPage = true
                            }
                        }, label: {
                            History(text: record.keyword!)
                        })
                        Button(action: {
                            searchHistoryHandler.deleteHistory(record: record)
                        }, label: {
                            Image(systemName: "trash.slash")
                                .imageScale(.large)
                                .foregroundColor(.red)
                        })
                    }.padding()
                }
            }
        }
    }
}

struct History: View {
    let text: String

    var body: some View {
        HStack {
            Image(systemName: "clock")
                .imageScale(.large)
                .padding(.trailing, 10)
                .foregroundColor(.secondary)
            Text(text)
                .font(.title2)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

struct SearchResult: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
                .padding(.trailing, 10)
                .foregroundColor(.secondary)
            Text(text)
                .font(.title2)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

//struct SearchHistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchHistoryView(searchText: .constant(""), gotoSearchResultPage: .constant(false))
//            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
//    }
//}
