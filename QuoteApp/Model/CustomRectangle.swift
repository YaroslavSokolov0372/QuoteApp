//
//  Rectangles.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 19/09/2023.
//

import Foundation
import SwiftUI



struct CustomRectangle: Identifiable, Equatable, ChangeID {
    
    var changeId = UUID()
    var color: LinearGradient
    var id: UUID {
        changeId
    }
    
    static func == (lhs: CustomRectangle, rhs: CustomRectangle) -> Bool {
        return lhs.id == rhs.id
    }
}
