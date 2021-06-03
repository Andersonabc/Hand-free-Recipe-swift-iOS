//
//  SearchBar.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/2.
//

import SwiftUI

struct SearchBar: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var enterSearchStatus: Bool
    @Binding var searchText: String
    @Binding var gotoSearchResultPage: Bool
    @State var text: String = ""

    let searchedText: String
    let inSearchResultPage: Bool

    var body: some View {
        HStack {
            if enterSearchStatus {
                Button(action: {
                    // endEditing should be put in the first update
                    // because of using UIResponder.resignFirstResponder
                    UIApplication.shared.endEditing()
                    enterSearchStatus = false
                    text = searchedText
                }) {
                    Image(systemName: "chevron.left")
                        .font(.bold(.title2)())
                }
            }
            else if inSearchResultPage {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
            }

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.primary)
                    .padding(.leading, 8)
                TextField("輸入食譜類別、食譜名稱...", text: $text) { _ in
                    
                } onCommit: {
                    if text != searchedText {
                        searchText = text
                        gotoSearchResultPage = true
                    }
                    enterSearchStatus = false
                }
                .onTapGesture {
                    enterSearchStatus = true
                }
            }
            .frame(height: 38)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.secondary, lineWidth: 1)
            )
            .padding()
        }
        .padding()
        .onAppear(perform: {
            UIScrollView.appearance().keyboardDismissMode = .onDrag
            text = searchedText
        })
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchBar(enterSearchStatus: .constant(false), searchText: .constant(""), gotoSearchResultPage: .constant(false), searchedText: "", inSearchResultPage: true)
        }
        .preferredColorScheme(.dark)
    }
}
