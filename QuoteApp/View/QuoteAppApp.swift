//
//  QuoteAppApp.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 30/08/2023.
//

import SwiftUI


@main
struct QuoteAppApp: App {
//    let persistenceController = PersistenceController.shared
    
//    let dataModel = PersistenceController()
    

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            Home()
                
        }
    }
}
