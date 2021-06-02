//
//  IngredientGroup.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/1.
//

import Foundation

class IngredientGroup: Ingredients {
    var children: [Ingredients]? {
        get {
            return self._children
        }
    }

    var name: String {
        get {
            self._name
        }
    }

    init(name: String) {
        self._name = name
        self._children = []
    }

    private let _name: String
    private var _children: [Ingredients]?

    func add(ingredient: Ingredients) {
        self._children?.append(ingredient)
    }
 
    func isComposite() -> Bool {
        return true
    }
}
