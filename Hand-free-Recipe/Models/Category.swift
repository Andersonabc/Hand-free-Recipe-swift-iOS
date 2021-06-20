//
//  Category.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/8.
//

import Foundation
import FirebaseFirestoreSwift

struct Category: Codable, Identifiable {
    @DocumentID var id: String?
    let categoryId: Int
    let name: String
    let image: String
}
