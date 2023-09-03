//
//  ArrayExtension.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 31/08/2023.
//

import Foundation


extension Array where Element: Equatable {
    
    func elementBefore(_ index: Index) -> Element? {
        if self.indices.contains(index - 1) {
            return self[index - 1]
        } else {
            return nil
        }
    }
    
    func nextElementAfter(_ index: Index) -> Element? {
        if self.indices.contains(index + 1) {
            return self[index + 1]
        } else {
            return nil
        }
    }
}
