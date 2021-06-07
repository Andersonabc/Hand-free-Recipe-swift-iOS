//
//  SearchViewModel.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import Foundation
import CoreData

class SearchViewModel: ObservableObject {
    @Published var results: [Recipe]?
    
    private let context = PersistenceController.shared.container.viewContext
    
    init() {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

extension SearchViewModel {
    func search(keyword: String) {
        DispatchQueue.global().async {
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
            
            DispatchQueue.main.sync {
                self.results = []
                print("sss")
            }
        }
    }

    func delete(record: SearchHistory) {
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
