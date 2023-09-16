//
//  HomeViewModel.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 14/09/2023.
//

import Foundation
import SwiftUI
import CoreData

class HomeVM: ObservableObject {
    
//    private var presistenceController = PersistenceController()
    
    
//    var firstFourCollections: [QuoteCollection?] {
//        return [
//            presistenceController.fetchAllCollections().nextElementAfter(currentCollectionIndex + 1),
//            presistenceController.fetchAllCollections().nextElementAfter(currentCollectionIndex),
//            presistenceController.fetchAllCollections()[currentCollectionIndex],
//            presistenceController.fetchAllCollections().elementBefore(currentCollectionIndex),
//        ]
//    }
    
    @Published var currentCollectionIndex = 0
    
    
    
    @Published var openCollection = false
    
    @Published var settingsMode = false
    
    @Published var nameOffCurrentCollection = "quotes from friends"
    
    @Published var draggOffset: CGFloat = 0
    
    @Published var playAnimation = false
    
    

    //MARK: - Temporary collection in type of Int
    
    @Published var arrayOfNumbers: [Int] = [07, 12, 32, 14, 42, 02, 01]
    
    var sortedArrayOfNumbers: [Int?] {
        return [arrayOfNumbers.nextElementAfter(currentCollectionIndex + 1) ?? nil,
                arrayOfNumbers.nextElementAfter(currentCollectionIndex) ?? nil,
                arrayOfNumbers[currentCollectionIndex],
                arrayOfNumbers.elementBefore(currentCollectionIndex) ?? nil
        ]
    }
    
    var sortedArrayOfNumbersFilled: [Int?] {
        return [
            arrayOfNumbers.nextElementAfter(currentCollectionIndex) ?? nil,
            arrayOfNumbers[currentCollectionIndex],
            arrayOfNumbers.elementBefore(currentCollectionIndex) ?? nil
        ]
    }

}

