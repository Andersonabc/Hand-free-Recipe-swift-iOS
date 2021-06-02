//
//  RecipeStep.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/2.
//

import Foundation

struct RecipeStep {
    var description: String {
        get {
            return self._description
        }
    }
    var image: String? {
        get {
            return self._image
        }
    }
    
    init(description: String, image: String?) {
        self._description = description
        self._image = image
    }

    private let _description: String
    private let _image: String?
}
