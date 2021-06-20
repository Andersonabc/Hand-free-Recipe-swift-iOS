//
//  CategoryLoader.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/8.
//

import Foundation
import Combine
import FirebaseFirestore
import SwiftUI

class CategoryLoader: ObservableObject {
    @Published var categories: [Category]
    @Published var images: [Int: UIImage]

    var dataIsFetched: Bool {
        !self.categories.isEmpty
    }

    private let topic: String

    private var cancellable: Set<AnyCancellable>
    
    private let db = Firestore.firestore()

    func load() {
        // TODO: Firebase request
        if !self.dataIsFetched {
            self.fetchData()
        }
    }

    func fetchData() {
        db.collection(self.topic).order(by: "categoryId").getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            
            let data = documents.compactMap({ snapshot in
                try? snapshot.data(as: Category.self)
            })

            DispatchQueue.main.async {
                self.categories = data
            }
        }
    }

    func reload() {
        self.categories = []
        self.load()
    }

    func cancel() {
        self.images = [:]
        self.categories = []
        self.cancellable.forEach({
            $0.cancel()
        })
    }

    init(db_topic: String) {
        self.topic = db_topic
        self.categories = []
        self.images = [:]
        self.cancellable = []
        

        self.$categories.sink { categories in
            if categories.isEmpty {
                return
            }

            categories.forEach { category in
                URLSession.shared.dataTaskPublisher(for: URL(string: category.image)!)
                    .map { UIImage(data: $0.data) }
                    .retry(10)
                    .replaceError(with: nil)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.images[category.categoryId] = $0
                        print(category.categoryId)
                    }.store(in: &self.cancellable)
            }
        }.store(in: &cancellable)
    }

    deinit {
        self.cancel()
    }
}
