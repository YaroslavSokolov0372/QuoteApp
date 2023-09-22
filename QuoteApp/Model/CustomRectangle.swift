//
//  Rectangles.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 19/09/2023.
//

import Foundation
import SwiftUI



struct CustomRectangle: Identifiable, Equatable {
    
    
    static func == (lhs: CustomRectangle, rhs: CustomRectangle) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
//    var position: Int
    var color: LinearGradient
    var id: UUID
    
//    mutating func changePosition() {
//        position += 1
//    }
    
    
//    init(position: Int, color: LinearGradient, id: UUID) {
//        self.position = position
//        self.color = color
//        self.id = id
//    }
    
}
