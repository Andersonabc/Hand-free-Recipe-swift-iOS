//
//  Helpers.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/2.
//

import Foundation
import LoremSwiftum

func generateFakeIngredients() -> [Ingredients] {
    var tmp = [Ingredients]()

    let nested = IngredientGroup(name: "烤肉醬")

    for _ in 0...3 {
        tmp.append(Ingredient(name: "透抽 10斤"))
        nested.add(ingredient: Ingredient(name: "透抽 10斤"))
    }
    
    tmp.append(nested)
    tmp.append(nested)

    return tmp
}

func generateFakeSteps() -> [RecipeStep] {
    var tmp = [RecipeStep]()
    
    for _ in 0...6 {
        tmp.append(RecipeStep(description: Lorem.sentences(2), image: "example_food"))
    }
    
    tmp.append(RecipeStep(description: Lorem.sentences(2), image: nil))

    return tmp
}
