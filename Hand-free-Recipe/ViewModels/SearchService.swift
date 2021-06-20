//
//  SearchService.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import Foundation
import CoreData
import FirebaseFirestore
import Combine

class SearchService: ObservableObject {
    @Published var keyword: String = ""
    @Published var historyResults = [SearchHistory]()
    @Published var searchResults = [String]()

    var subscriptions = Set<AnyCancellable>()
    
    private let context = PersistenceController.shared.container.viewContext
    
    private let db = Firestore.firestore()

    init() {
        
        $keyword
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { data in
                self.searchResults.removeAll()
                self.searchByKeyword(keyword: data)
            })
            .store(in: &subscriptions)
        $keyword
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map({ data -> [SearchHistory] in
                self.searchByHistory(keyword: data)
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$historyResults)
        
        
    }
}

extension SearchService {
    func searchByKeyword(keyword: String) {
        db.collection("category").whereField("name", isEqualTo: keyword).limit(to: 30).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let data = documents.compactMap({ snapshot -> String in
                let data = snapshot.data()
                return data["name"] as! String
            })

            DispatchQueue.main.async {
                self.searchResults.append(contentsOf: data)
            }
        }

        db.collection("Recipe").whereField("name", isGreaterThanOrEqualTo: keyword).limit(to: 30).getDocuments { snapshot, error in
            
            guard let documents = snapshot?.documents else { return }
            
            let data = documents.compactMap({ snapshot -> String in
                let data = snapshot.data()
                return data["name"] as! String
            })
            
            DispatchQueue.main.async {
                self.searchResults.append(contentsOf: data)
            }
        }
    }
    
    func searchByHistory(keyword: String) -> [SearchHistory] {
        let request: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        request.predicate = NSPredicate(format: "keyword == %@", keyword)
        
        guard let result = try? context.fetch(request) else { return [] }

        return result
    }
}
