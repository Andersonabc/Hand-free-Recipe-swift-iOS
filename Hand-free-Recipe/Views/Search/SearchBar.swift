//
//  SearchBar.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/2.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

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
                    withAnimation(.easeOut(duration: 0.1)) {
                        enterSearchStatus = false
                    }
                    text = searchedText
                }) {
                    Image(systemName: "chevron.left")
                        .font(.bold(.title2)())
                }.padding(.leading)
            }
            else if inSearchResultPage {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }.padding(.leading)
            }
            else {
                EmptyView()
            }

            HStack {
                Image(systemName: "magnifyingglass")
                    .font(Font.system(size: 18, weight: .light))
                    .foregroundColor(.primary)
                    .padding(.leading, 10)
                ZStack(alignment: .leading) {
                    if text.isEmpty { Text("輸入食譜類別、食譜名稱...").foregroundColor(Color.init(.sRGB, white: 1, opacity: 0.6)) }
                    TextField("", text: $text) { _ in
                        
                    } onCommit: {
                        if text != searchedText {
                            searchText = text
                            gotoSearchResultPage = true
                        }
                        enterSearchStatus = false
                    }
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            enterSearchStatus = true
                        }
                    }
                }
            }
            .frame(height: 45)
            .background(Color(.sRGB, red: 61/255, green: 61/255, blue: 61/255, opacity: 0.6))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.secondary, lineWidth: 1)
            )
            .padding()
        }
        .onAppear(perform: {
            text = searchedText
        })
        .background(Color(red: 20/255, green: 20/255, blue: 20/255).edgesIgnoringSafeArea(.vertical))
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchBar(enterSearchStatus: .constant(false), searchText: .constant(""), gotoSearchResultPage: .constant(false), searchedText: "", inSearchResultPage: false)
        }
        .preferredColorScheme(.dark)
    }
}
