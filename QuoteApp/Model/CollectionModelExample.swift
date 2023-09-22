//
//  CollectionModelExample.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 21/09/2023.
//

import Foundation
import SwiftUI

struct CollectionModel: Identifiable, Equatable, Hashable {
    var num: Int
    var id = UUID()
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
