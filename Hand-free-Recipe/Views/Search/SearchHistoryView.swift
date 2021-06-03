//
//  SearchHistoryView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import SwiftUI

struct SearchHistoryView: View {
    //    private var Items = [ SearchRecord(name: "Chicken and waffles"),
    //                          SearchRecord(name: "Sweet potato casserole"),
    //                          SearchRecord(name: "Meatloaf"),
    //                          SearchRecord(name: "Taco"),
    //                          SearchRecord(name: "fish and chips")
    //                                ]
    @Binding var records: [SearchHistory]
    
    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            Text("Hello, World!")
        }
    }
}

struct SearchHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryView(records: .constant([]))
    }
}
