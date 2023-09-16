//
//  HomeModel.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 15/09/2023.
//

import Foundation
import SwiftUI
import CoreData


struct PersistenceController {


     let contrainer: NSPersistentContainer


    init() {
        contrainer = NSPersistentContainer(name: "QuoteApp")
        contrainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load data: \(error.localizedDescription)")
            }
            print("Succesfully loaded prersistance")
        }
    }

    func saveQuote() {

    }

    private func saveCollection() {

    }

    func updateQuote() {

    }

    func updateCollecion() {

    }

    func fetchAllCollections() -> [QuoteCollection] {
        let fetchRequest: NSFetchRequest<QuoteCollection> = QuoteCollection.fetchRequest()

        do {
            return try contrainer.viewContext.fetch(fetchRequest)
        } catch {
            fatalError("Failed to load collections \(error.localizedDescription)")
        }
    }


}

