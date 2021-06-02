//
//  SearchBar.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/2.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    @Binding var gotoSearchPage: Bool
    @Binding var hist: History
    var body: some View {
        HStack {
            TextField("Search ...", text: $text, onCommit: {
                self.gotoSearchPage = true
                hist.appendHist(at: SearchRecord(name: text))
                //self.history.append(searchRecord(name: self.text))
                //self.searchedText = self.text
                //print(self.history.count)
            })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8).overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                self.gotoSearchPage = false
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                    self.gotoSearchPage = false
                }
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    self.gotoSearchPage = false
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
