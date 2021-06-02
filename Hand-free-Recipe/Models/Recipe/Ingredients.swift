//
//  Ingredients.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/1.
//

import Foundation

protocol Ingredients {
    var children: [Ingredients]? { get }
    var name: String { get }
    func add(ingredient: Ingredients) -> Void
    func isComposite() -> Bool
}

extension Ingredients {
    func add(ingredient: Ingredients) {}
}
