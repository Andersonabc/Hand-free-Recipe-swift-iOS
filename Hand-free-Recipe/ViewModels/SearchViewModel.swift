//
//  SearchViewModel.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import Foundation
import CoreData

class SearchViewModel: ObservableObject {
    @Published var historyRecords = [SearchHistory]()

    private let context = PersistenceController.shared.container.viewContext
}

extension SearchViewModel {
    func fetchHistory() {
        let request: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        guard let data: [SearchHistory] = try? context.fetch(request) else {
            print("Error: Couldn't fetch history data from Core Data")
            return
        }
        
        if !data.isEmpty {
            self.historyRecords = data
        }
    }
    
    func search(keyword: String) {
        
    }
}
