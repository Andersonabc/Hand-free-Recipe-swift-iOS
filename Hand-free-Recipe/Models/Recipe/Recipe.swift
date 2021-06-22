//
//  Recipe.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/5/31.
//

import Foundation

class Recipe: Hashable {
    static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self._id)
    }

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
    
    var estimatedTime: Int {
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
    
    var yields: Int {
        get {
            return self._yields
        }
    }
    
    var id: String {
        get {
            return self._id
        }
    }
    
    var categoryIds: [Int] {
        get {
            return self._categoryIds
        }
    }

    init(categoryIds: [Int], id: String, name: String, coverImage: String, ingredients: [Ingredients], steps: [RecipeStep], estimatedTime: Int, yields: Int) {
        self._categoryIds = categoryIds
        self._id = id
        self._name = name
        self._coverImage = coverImage
        self._estimatedTime = estimatedTime
        self._ingredients = ingredients
        self._steps = steps
        self._yields = 1
    }

    private let _categoryIds: [Int]
    private let _id: String
    private let _name: String
    private let _coverImage: String
    private let _estimatedTime: Int
    private let _ingredients: [Ingredients]
    private let _steps: [RecipeStep]
    private let _yields: Int
}
