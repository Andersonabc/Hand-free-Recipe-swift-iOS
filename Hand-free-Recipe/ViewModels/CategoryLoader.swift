//
//  CategoryLoader.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/8.
//

import Foundation
import Combine

class CategoryLoader: ObservableObject {
    @Published var categories: [Category]
    var dataIsFetched: Bool {
        !self.categories.isEmpty
    }

    private let topic: String

    private var cancellable: AnyCancellable?

    func load() {
        // TODO: Firebase request
        if !self.dataIsFetched {
            self.categories.append(Category(categoryId: 1, name: "test", image: "example_food"))
        }
    }

    func reload() {
        self.categories = []
        self.load()
    }

    func cancel() {
        self.cancellable?.cancel()
    }

    init(db_topic: String) {
        self.topic = db_topic
        self.categories = []
    }

    deinit {
        self.cancel()
    }
}
