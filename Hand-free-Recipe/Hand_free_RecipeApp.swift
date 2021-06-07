//
//  Hand_free_RecipeApp.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/5/31.
//

import SwiftUI

@main
struct Hand_free_RecipeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
            NavigationView {
                SearchView(viewModel: SearchViewModel(), searchedText: "", inSearchResultPage: false)
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .preferredColorScheme(.dark)
        }
    }
}
