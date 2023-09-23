//
//  Rectangles.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 19/09/2023.
//

import Foundation
import SwiftUI



struct CustomRectangle: Identifiable, Equatable {
    
    var color: LinearGradient
    var id: UUID
    
    static func == (lhs: CustomRectangle, rhs: CustomRectangle) -> Bool {
        return lhs.id == rhs.id
    }
}
