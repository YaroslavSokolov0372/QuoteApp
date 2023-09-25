//
//  QuoteAppApp.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 30/08/2023.
//

import SwiftUI
import SwiftData

@main
struct QuoteAppApp: App {

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            Home()
                .modelContainer(for: [Quote.self, CollectionsOfQuote.self])
//            RemakeHomeView()
//            HomeViewSketch()
//            RemakeHomeView()
                
        }
    }
}
