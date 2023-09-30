//
//  BindingExtension.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 28/09/2023.
//

import Foundation
import SwiftUI


extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
