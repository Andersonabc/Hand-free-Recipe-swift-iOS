//
//  SearchHistory+CoreDataProperties.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//
//

import Foundation
import CoreData


extension SearchHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchHistory> {
        return NSFetchRequest<SearchHistory>(entityName: "SearchHistory")
    }

    @NSManaged public var keyword: String?
    @NSManaged public var timestamp: Date?

}

extension SearchHistory : Identifiable {

}
