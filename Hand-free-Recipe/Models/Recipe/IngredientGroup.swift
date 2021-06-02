//
//  IngredientGroup.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/1.
//

import Foundation

class IngredientGroup: Ingredients {
    var children: [Ingredients]?
    private let name: String

    init(name: String) {
        self.name = name
        self.children = []
    }

    func getName() -> String {
        return self.name
    }

    func add(ingredient: Ingredients) {
        self.children?.append(ingredient)
    }
 
    func isComposite() -> Bool {
        return true
    }
}
