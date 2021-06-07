//
//  CategoryLoader.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/8.
//

import Foundation
import Combine

class CategoryLoader {
    @Published var categories: [Category]?
    private let topic: String

    private var cancellable: AnyCancellable?
    
    func load() {
        if self.categories != nil {
            return
        }
        
        
    }
    
    func reload() {
        self.categories = nil
        self.load()
    }

    init(db_topic: String) {
        self.topic = db_topic
    }
}
