//
//  QuoteCollection.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 29/09/2023.
//

import Foundation
import SwiftUI
import SwiftData


@Model
class QuoteCollection: Identifiable, ChangeID {
    
    var changeId = UUID()
    var name: String
    var datestamp: Date
    @Relationship var quotes: [Quote]
    var id: UUID {
        return changeId
    }
    
    var formattedDate: String {
            let formater = DateFormatter()
        formater.dateFormat = "MM-dd-yy HH:mm:ss"
        return formater.string(from: datestamp)

    }
    
    init(name: String, quotes: [Quote], id: UUID = .init(), datestamp: Date) {
        self.name = name
        self.quotes = quotes
        self.datestamp = datestamp
    }
}
