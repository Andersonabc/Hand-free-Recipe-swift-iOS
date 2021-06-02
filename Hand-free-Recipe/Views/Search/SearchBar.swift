//
//  SearchBar.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/2.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    @Binding var gotoSearchPage: Bool
    @Binding var hist: History
    var body: some View {
        HStack {
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    self.gotoSearchPage = false
                }) {
                    Image(systemName: "arrow.turn.up.left").resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(.leading, 10).foregroundColor(.white)
            }
            TextField("Search ...", text: $text, onCommit: {
                self.gotoSearchPage = true
                hist.appendHist(at: SearchRecord(name: text))
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
        }
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
