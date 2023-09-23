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
    
    

    @Published var currentCollectionIndex = 1
    
    @Published var currentRectangle = 1
    
    @Published var arrayRectangles: [CustomRectangle] = []
    
    @Published var openCollection = false
    
    @Published var settingsMode = false
    
    @Published var nameOffCurrentCollection = "quotes from friends"
    
    @Published var draggOffset: CGFloat = 0
    
//    @Published var playAnimation = false
    
    
    
    //MARK: - Temporary collection in type of Int
    
    //    @Published var arrayOfNumbers: [Int] = [07, 12, 32, 14, 42, 02, 01, 10]
    @Published var arrayOfNumbers = [CollectionModel(num: 07),
                                     CollectionModel(num: 12),
                                     CollectionModel(num: 32),
                                     CollectionModel(num: 14),
                                     CollectionModel(num: 42),
                                     CollectionModel(num: 02),
                                     CollectionModel(num: 01),
                                     CollectionModel(num: 10)
    ]
    
    @Published var arrayOfNumbersFaked: [CollectionModel] = []
    
    init() {
        self.arrayOfNumbersFaked = arrayOfNumbers
        
    }

    
    //MARK: Func for Infinity Carousel
    
    func appendNextCollectionAfter(_ lastItem: CollectionModel?) {
        
        if lastItem != nil {
            if var itemIndex = arrayOfNumbers.firstIndex(where: { $0.num == lastItem!.num }) {
                if itemIndex == arrayOfNumbers.count - 1 {
                    itemIndex = 0
                    var nextElement = arrayOfNumbers[itemIndex]
                    nextElement.id = .init()
                    arrayOfNumbersFaked.append(nextElement)
                } else {
                    itemIndex += 1
                    var nextElement = arrayOfNumbers[itemIndex]
                    nextElement.id = .init()
                    arrayOfNumbersFaked.append(nextElement)
                }
            }
        }
    }
    
    func insertNextCollectionAfter(_ firstItem: CollectionModel?, realCollection: [CollectionModel]) {
        if firstItem != nil {
            if var itemIndex = realCollection.firstIndex(where: { $0.num == firstItem!.num }) {
                if itemIndex == 0 {
                    itemIndex = realCollection.count - 1
                    var nextElement = realCollection[itemIndex]
                    nextElement.id = .init()
                    arrayOfNumbersFaked.insert(nextElement, at: 0)
                } else {
                    itemIndex -= 1
                    var nextElement = realCollection[itemIndex]
                    nextElement.id = .init()
                    arrayOfNumbersFaked.insert(nextElement, at: 0)
                }
            }
        }
    }
    
    func insertNextGradientAfter(_ lastItem: CustomRectangle, realCollection: [LinearGradient]) {
        
        if var itemIndex = realCollection.firstIndex(where: { $0 == lastItem.color }) {
            if itemIndex == 0 {
                itemIndex = realCollection.count - 1
                arrayRectangles.insert(CustomRectangle(color: realCollection[itemIndex], id: .init()), at: 0)
            } else {
                arrayRectangles.insert(CustomRectangle(color: realCollection[itemIndex - 1], id: .init()), at: 0)
            }
        }
    }

    func appentNextGradientAfter(_ lastItem: CustomRectangle, realCollection: [LinearGradient]) {
        
        if var itemIndex = realCollection.firstIndex(where: { $0 == lastItem.color }) {
            if itemIndex == realCollection.count - 1 {
                itemIndex = 0
                arrayRectangles.append(CustomRectangle(color: realCollection[itemIndex], id: .init()))
            } else {
                itemIndex += 1
                arrayRectangles.append(CustomRectangle(color: realCollection[itemIndex], id: .init()))
            }
        }
        
    }
    
    func shouldRemoveRectangles(passed: Int) -> Bool {
        var passedCount = 0
        for index in arrayRectangles.indices {
            if index < currentRectangle {
                passedCount += 1
            }
        }
        return passedCount >= passed
    }
    
    func shouldRemoveCollections(passed: Int) -> Bool {
        var passedCount = 0
        for index in arrayOfNumbersFaked.indices {
            if index < currentCollectionIndex {
                passedCount += 1
            }
        }
        return passedCount >= passed
    }

    var sortedArrayOfNumbers: [CollectionModel?] {
        return [arrayOfNumbersFaked.nextElementAfter(currentCollectionIndex + 1) ?? nil,
                arrayOfNumbersFaked.nextElementAfter(currentCollectionIndex) ?? nil,
                arrayOfNumbersFaked[currentCollectionIndex],
                arrayOfNumbersFaked.elementBefore(currentCollectionIndex) ?? nil
        ]
    }
    
    var sortedArrayOfNumbersFilled: [CollectionModel?] {
        return [
            arrayOfNumbersFaked.nextElementAfter(currentCollectionIndex) ?? nil,
            arrayOfNumbersFaked[currentCollectionIndex],
            arrayOfNumbersFaked.elementBefore(currentCollectionIndex) ?? nil
        ]
    }
    
}


