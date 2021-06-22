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
    var isLastPage: Bool {
        self.lastCount != -1 && self.lastCount < self.size
    }
    var lastSnapshot: QueryDocumentSnapshot? {
        self._lastSnapshot
    }

    private let keyword: String
    private let size: Int
    private let after: QueryDocumentSnapshot?
    private let db = Firestore.firestore()
    
    private var _lastSnapshot: QueryDocumentSnapshot?
    private var id: Int?

    private var lastCount: Int

    init(keyword: String, size: Int, categoryId: Int = -1) {
        self.keyword = keyword
        self.size = size
        self.lastCount = -1
        self.after = nil
        if categoryId != -1 {
            self.id = categoryId
        }
    }

    init(keyword: String, after: QueryDocumentSnapshot, size: Int, categoryId: Int = -1) {
        self.keyword = keyword
        self.size = size
        self.lastCount = -1
        self.after = after
        if categoryId != -1 {
            self.id = categoryId
        }
    }

    func load() {
        if !self.results.isEmpty {
            return
        }

        if let id = self.id {
            self.fetchRecipeByCategoryId(id: id)
        }
        else {
            db.collection("category").whereField("name", in: [keyword, keyword.lowercased(), keyword.capitalized]).getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                
                if let id = documents.first?.data()["categoryId"] as? Int {
                    self.id = id
                    self.fetchRecipeByCategoryId(id: id)
                }
                else if !self.keyword.isEmpty {
                    self.fetchRecipeByName()
                }
                else {
                    self.fetchRecipe()
                }
            }
        }
    }

    func next() {
        if self.id != nil {
            self.fetchRecipeByCategoryId(id: self.id!)
        }
        else if !self.keyword.isEmpty {
            self.fetchRecipeByName()
        }
        else {
            self.fetchRecipe()
        }
    }

    func fetchRecipeByCategoryId(id: Int) {
        var line = db.collection("Recipe").whereField("categoryId", arrayContains: id)

        if _lastSnapshot != nil {
            line = line.start(afterDocument: _lastSnapshot!)
        }
        else if self.after != nil {
            line = line.start(afterDocument: self.after!)
        }

        line.limit(to: size).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            self._lastSnapshot = documents.last

            self.lastCount = documents.count
            
            let data = documents.compactMap { snapshot -> Recipe in
                self.createNewRecipe(id: snapshot.documentID, data: snapshot.data())
            }
    
            DispatchQueue.main.async {
                self.results.append(contentsOf: data)
            }
        }
    }

    func fetchRecipeByName() {
        var line = db.collection("Recipe").whereField("name", isGreaterThanOrEqualTo: self.keyword)

        if _lastSnapshot != nil {
            line = line.start(afterDocument: _lastSnapshot!)
        }
        else if self.after != nil {
            line = line.start(afterDocument: self.after!)
        }

        line.limit(to: size).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }

            self._lastSnapshot = documents.last

            self.lastCount = documents.count

            let data = documents.compactMap { snapshot -> Recipe in
                self.createNewRecipe(id: snapshot.documentID, data: snapshot.data())
            }

            DispatchQueue.main.async {
                self.results.append(contentsOf: data)
            }
        }
    }
    
    func fetchRecipe() {
        var line = db.collection("Recipe").limit(to: size)

        if _lastSnapshot != nil {
            line = line.start(afterDocument: _lastSnapshot!)
        }
        else if self.after != nil {
            line = line.start(afterDocument: self.after!)
        }

        line.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }

            self._lastSnapshot = documents.last

            self.lastCount = documents.count

            let data = documents.compactMap { snapshot -> Recipe in
                self.createNewRecipe(id: snapshot.documentID, data: snapshot.data())
            }

            DispatchQueue.main.async {
                self.results.append(contentsOf: data)
            }
        }
    }

    func createNewRecipe(id: String, data: [String : Any]) -> Recipe {
        let categoryIds = data["categoryId"] as! [Int]
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
        
        return Recipe(categoryIds: categoryIds, id: id, name: name, coverImage: cover, ingredients: _ingredients, steps: _instruction, estimatedTime: duration, yields: yields)
    }
}
