//
//  SearchRecord.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/2.
//

import Foundation
class SearchRecord: Identifiable {
    var id = UUID()
    var name: String = ""

    init() {
        //
    }
     
    init(name: String) {
        self.name = name
    }
}
