//
//  QuoteModel.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 17/09/2023.
//

import Foundation
import SwiftUI
import SwiftData

struct QuoteExample: Hashable, Identifiable {
    
    var quote: String
    var whomQuote: String
    var id = UUID()
    
}



@Model
class Quote: Identifiable, ChangeID {
    
    var changeId = UUID()
    var id: UUID {
        return changeId
    }
    var quote: String
    var whomQuote: String
    var date: Date
    var resource: String
    
    init(quote: String, whomQuote: String, date: Date, resource: String) {
        self.quote = quote
        self.whomQuote = whomQuote
        self.date = date
        self.resource = resource
    }
}


@Model
class CollectionsOfQuote: Identifiable, ChangeID {
    
    var changeId = UUID()
    var id: UUID {
        return changeId
    }
//    @Attribute(.unique)
    var name: String
    var quotes: [Quote]
    
    init(name: String, quotes: [Quote], id: UUID = .init()) {
        self.name = name
        self.quotes = quotes
    }
}

protocol ChangeID {
    var changeId: UUID { get set }
}
