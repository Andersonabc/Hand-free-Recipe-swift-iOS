//
//  Recipe.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/5/31.
//

import Foundation

class Recipe {
    var coverImage: String {
        get {
            return self._coverImage
        }
    }
    
    var name: String {
        get {
            self._name
        }
    }
    
    var estimatedTime: Int? {
        get {
            return self._estimatedTime
        }
    }
    
    var ingredients: [Ingredients] {
        get {
            return self._ingredients
        }
    }
    
    var steps: [RecipeStep] {
        get {
            return self._steps
        }
    }
    
    init(name: String, coverImage: String, ingredients: [Ingredients], steps: [RecipeStep], estimatedTime: Int?) {
        self._name = name
        self._coverImage = coverImage
        self._estimatedTime = estimatedTime
        self._ingredients = ingredients
        self._steps = steps
    }

    private let _name: String
    private let _coverImage: String
    private let _estimatedTime: Int?
    private let _ingredients: [Ingredients]
    private let _steps: [RecipeStep]
}
