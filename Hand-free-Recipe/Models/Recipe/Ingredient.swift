//
//  Ingredient.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/1.
//

import Foundation

class Ingredient: Ingredients {
    var children: [Ingredients]?
    private let name: String
    
    init(name: String) {
        self.name = name
        self.children = nil
    }

    func getName() -> String {
        return self.name
    }
    
    func isComposite() -> Bool {
        return false
    }
}
