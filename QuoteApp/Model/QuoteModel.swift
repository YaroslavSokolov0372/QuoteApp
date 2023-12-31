//
//  QuoteModel.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 17/09/2023.
//

import Foundation
import SwiftUI
import SwiftData



@Model
class Quote: Identifiable, ChangeID, Equatable {
    
    var changeId = UUID()
    var quote: String
    var whomQuote: String
    var datestamp: Date
    var resource: String
    var id: UUID {
        return changeId
    }
    
    var formattedDate: String {
            let formater = DateFormatter()
        formater.dateFormat = "MM-dd-yy HH:mm:ss"
        return formater.string(from: datestamp)

    }
    
    init(quote: String, whomQuote: String, datestamp: Date, resource: String) {
        self.quote = quote
        self.whomQuote = whomQuote
        self.datestamp = datestamp
        self.resource = resource
    }
}




