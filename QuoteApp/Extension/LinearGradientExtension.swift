//
//  Extension LinearGradient.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 21/09/2023.
//

import Foundation
import SwiftUI


extension LinearGradient: Equatable {
    public static func == (lhs: LinearGradient, rhs: LinearGradient) -> Bool {
        return String(describing: lhs) == String(describing: rhs)
    }
}
