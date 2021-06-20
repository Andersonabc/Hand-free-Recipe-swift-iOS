//
//  SearchResultLoader.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/8.
//

import Foundation
import FirebaseFirestore

class SearchResultLoader: ObservableObject {
    @Published var results = [Recipe]()
    
    private let keyword: String
    private let size: Int
    private let db = Firestore.firestore()
    
    private var lastSnapshot: QueryDocumentSnapshot?
    private var id: Int?

    init(keyword: String, size: Int) {
        self.keyword = keyword
        self.size = size
    }

    func load() {
        if !self.results.isEmpty {
            return
        }
        
        db.collection("category").whereField("name", in: [keyword, keyword.lowercased()]).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            if let id = documents.first?.data()["categoryId"] as? Int {
                self.id = id
                self.fetchRecipeByCategoryId(id: id)
            }
            else {
                self.fetchRecipeByName()
            }
        }
    }

    func next() {
        if self.id != nil {
            self.fetchRecipeByCategoryId(id: self.id!)
        }
        else {
            self.fetchRecipeByName()
        }
    }

    func fetchRecipeByCategoryId(id: Int) {
        var line = db.collection("Recipe").whereField("categoryId", arrayContains: id)
        
        if lastSnapshot != nil {
            line = line.start(afterDocument: lastSnapshot!)
        }
            
        line.limit(to: size).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            self.lastSnapshot = documents.last

            let data = documents.compactMap { snapshot -> Recipe in
                self.createNewRecipe(data: snapshot.data())
            }
            
            DispatchQueue.main.async {
                self.results.append(contentsOf: data)
            }
        }
    }

    func fetchRecipeByName() {
        var line = db.collection("Recipe").whereField("name", isGreaterThanOrEqualTo: self.keyword)
        
        if lastSnapshot != nil {
            line = line.start(afterDocument: lastSnapshot!)
        }
            
        line.limit(to: size).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            self.lastSnapshot = documents.last

            let data = documents.compactMap { snapshot -> Recipe in
                self.createNewRecipe(data: snapshot.data())
            }
            
            DispatchQueue.main.async {
                self.results.append(contentsOf: data)
            }
        }
    }
    
    func createNewRecipe(data: [String : Any]) -> Recipe {
        let name = data["name"] as! String
        let cover = data["imageUrl"] as! String
        let duration = data["total_time"] as! Int
        let yields = data["yields"] as! Int
        let ingredients = data["ingredients"] as! [String]
        let instructions = data["instructions"] as! [String]
        
        var _ingredients = [Ingredients]()
        ingredients.forEach { ingredient in
            _ingredients.append(Ingredient(name: ingredient))
        }
        
        var _instruction = [RecipeStep]()
        instructions.forEach { instruction in
            _instruction.append(RecipeStep(description: instruction, image: nil))
        }
        
        return Recipe(name: name, coverImage: cover, ingredients: _ingredients, steps: _instruction, estimatedTime: duration, yields: yields)
    }
}
