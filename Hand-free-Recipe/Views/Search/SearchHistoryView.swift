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

    @Binding var searchText: String
    @Binding var gotoSearchResultPage: Bool

    let searchHistoryHandler = SearchHistoryHandler.shared

    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            ForEach(records) { record in
                HStack {
                    Button(action: {
                        searchText = record.keyword!
                        gotoSearchResultPage = true
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

struct SearchHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryView(searchText: .constant(""), gotoSearchResultPage: .constant(false))
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
