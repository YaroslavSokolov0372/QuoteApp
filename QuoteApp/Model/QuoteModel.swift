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
    var datestamp: Date
    var resource: String
    
    init(quote: String, whomQuote: String, datestamp: Date, resource: String) {
        self.quote = quote
        self.whomQuote = whomQuote
        self.datestamp = datestamp
        self.resource = resource
    }
}


@Model
class QuoteCollections: Identifiable, ChangeID {
    
    var changeId = UUID()
    var id: UUID {
        return changeId
    }
    var name: String
    var quotes: [Quote]
    var datestamp: Date
    
    var formattedDate: String {
            let formater = DateFormatter()
        formater.dateFormat = "MM-dd-yy HH:mn:ss"
//        print(formater.string(from: datestamp))
        return formater.string(from: datestamp)

    }
    
    init(name: String, quotes: [Quote], id: UUID = .init(), datestamp: Date) {
        self.name = name
        self.quotes = quotes
        self.datestamp = datestamp
    }
}

protocol ChangeID {
    var changeId: UUID { get set }
}
