//
//  SearchResultView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import SwiftUI

struct SearchResultView: View {
    let keyword: String

    var body: some View {
        ScrollView {
            Text("Hello, World!")
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(keyword: "")
    }
}
