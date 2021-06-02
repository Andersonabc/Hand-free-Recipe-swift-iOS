//
//  ContentView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/5/31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
    //private var items: FetchedResults<Item>

    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.primary)
    }
    
    var body: some View {
//        List {
//            ForEach(items) { item in
//                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
        
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
                SearchView()
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

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
    }
}
