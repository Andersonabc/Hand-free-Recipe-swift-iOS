//
//  ContentView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/5/31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var searchService: SearchService = SearchService()

    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.primary)
    }
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }.navigationTitle("Home")
            .tabItem {
                Image(systemName: "house")
                    .resizable()
                    .font(.largeTitle)
            }.tag(1)
            NavigationView {
                SearchView(searchedText: "", inSearchResultPage: false)
                    .environmentObject(searchService)
            }.navigationTitle("Search")
            .tabItem {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .font(.largeTitle)
            }.tag(2)
            NavigationView {
                HistoryView()
            }.navigationTitle("Favorite/History")
            .tabItem {
                Image(systemName: "heart")
                    .resizable()
                    .font(.largeTitle)
            }.tag(3)
        }.accentColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
