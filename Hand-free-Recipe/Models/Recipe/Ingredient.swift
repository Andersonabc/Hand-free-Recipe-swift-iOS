//
//  Ingredient.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/1.
//

import Foundation

class Ingredient: Ingredients {
    var children: [Ingredients]? {
        get {
            return nil
        }
    }

    var name: String {
        get {
            return self._name
        }
    }
    
    init(name: String) {
        self._name = name
    }

    private let _name: String

    func isComposite() -> Bool {
        return false
    }
}
