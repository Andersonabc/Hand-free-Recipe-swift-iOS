//
//  SearchViewModel.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published var results = [String]()

    var subscriptions = Set<AnyCancellable>()

    init() {
        $keyword
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ data -> [String] in
                if data.isEmpty {
                    return []
                }
                return []
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$results)
    }
}

extension SearchViewModel {
    func searchByCategory(keyword: String) -> AnyPublisher<[Category], Error> {
        
    }
}
