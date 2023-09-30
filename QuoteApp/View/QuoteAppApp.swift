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
            Home()
        }
        .modelContainer(for: [QuoteCollection.self, Quote.self])
    }
}



