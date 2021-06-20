//
//  SearchHistoryHandler.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/8.
//

import Foundation
import CoreData

class SearchHistoryHandler {
    static let shared = SearchHistoryHandler()
    private let context = PersistenceController.shared.container.viewContext

    init() {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    func addHistory(keyword: String) {
        self.context.perform {
            let newRecord = SearchHistory(context: self.context)
            newRecord.keyword = keyword
            newRecord.timestamp = Date()

            do {
                try self.context.save()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }

    func deleteHistory(record: SearchHistory) {
        self.context.perform {
            self.context.delete(record)
            
            do {
                try self.context.save()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
