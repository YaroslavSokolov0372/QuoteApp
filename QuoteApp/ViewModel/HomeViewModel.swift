//
//  HomeViewModel.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 14/09/2023.
//

import Foundation
import SwiftUI
import SwiftData


class HomeVM: ObservableObject {
    
    var modelContext: ModelContext? = nil
    
    @Published var quoteCollections: [CollectionsOfQuote] = []
    
    @Published var fakedQuoteCollections: [CollectionsOfQuote] = []
    
    @Published var text = ""
    
    @Published var currentCollectionIndex = 1
    
    @Published var currentRectangle = 1
    
    @Published var arrayRectangles: [CustomRectangle] = []
    
    @Published var openCollection = false
    
    @Published var settingsMode = false
    
    @Published var nameOffCurrentCollection = "quotes from friends"
    
    @Published var draggOffset: CGFloat = 0
    
    func currentIndexExist() -> Bool {
        return fakedQuoteCollections.elementByIndex(currentCollectionIndex) != nil
    }
    
    func collecitonIsEqualToCurrent(_ collection: CollectionsOfQuote?) -> Bool {
        
        
        if currentIndexExist() {
            return fakedQuoteCollections[currentCollectionIndex] == collection
        } else {
            return false
        }
    }

    
    //MARK: SwiftData service
    
    func fetchCollections() {
        let fetchDescriptor = FetchDescriptor<CollectionsOfQuote>()
        
        if modelContext != nil {
            do {
                quoteCollections = try modelContext!.fetch(fetchDescriptor)
                
            } catch {
                print("faile to fetch collections of Quote")
            }
        }
//        print(quoteCollections.count)
        
    }
    
    func updateData() {
        
        if currentIndexExist() {
            quoteCollections[currentCollectionIndex].name = text
            try? modelContext?.save()
        }
    }
    
    func prepareForSettingsMode() {
        if currentIndexExist() {
            text = fakedQuoteCollections[currentCollectionIndex].name
        }
    }
    
    
    func deleteCollection() {
        
        if currentIndexExist() {
            modelContext?.delete(quoteCollections[currentCollectionIndex])
            
            try? modelContext?.save()
            
            fetchCollections()
            
            setUpFakedCollections()
            
            prepareForSettingsMode()

//            if fakedQuoteCollections.count - 1 == currentCollectionIndex {
//                currentCollectionIndex -= 1
//            } else 
            if fakedQuoteCollections.count == 1 {
                currentCollectionIndex = 0
            }
            
//            currentCollectionIndex -= 1
        }
        
//        if currentIndexExist() {
//            
//            modelContext?.delete(quoteCollections[currentCollectionIndex])
//            
//            try? modelContext?.save()
//            
//            print(quoteCollections.count)
//            
//            fetchCollections()
//            
//            setUpFakedCollections()
//            
////            currentCollectionIndex -= 1
//            currentRectangle -= 1
//            
////            if isCurrentIndexExist() {
////                text = fakedQuoteCollections[currentCollectionIndex].name
////            } else {
////                text = ""
////            }
//        }
//        print(currentCollectionIndex)
        print(fakedQuoteCollections)
        
    }
    
    func createNewCollection() {
        
//        text = ""
        
        let newCollection = CollectionsOfQuote(name: "", quotes: [], id: .init())
        
//                    if  fakedQuoteCollections.count == 1 {
//                        currentRectangle = 1
//                    }

        modelContext?.insert(newCollection)
        
        fetchCollections()
        
        setUpFakedCollections()
        
        
        
        

        
//        if fakedQuoteCollections.count > 2 {
//            currentCollectionIndex = quoteCollections.count - 1
//        }
        
        settingsMode.toggle()
        

        
        
        //        text = ""
        //        let newCollection = CollectionsOfQuote(name: text, quotes: [])
        //        modelContext?.insert(newCollection)
        //        try? modelContext?.save()
        //
        //
        
        //
        //                setUpFakedCollections()
        //
        //        currentCollectionIndex = fakedQuoteCollections.count - 1
        //
        //        settingsMode = true
        
        
//        print(currentCollectionIndex)
        print(fakedQuoteCollections)

        
    }
    
    func setUpFakedCollections() {
        fakedQuoteCollections = quoteCollections
//        if quoteCollections.count > 4 {
//            for collection in sortedArrayOfCollection.reversed() {
//                if collection != nil {
//                    collection?.changeId = UUID()
//                    fakedQuoteCollections.append(collection!)
//                }
//            }
//        }
    }
    
    
    
    
    
    
    

    
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
    
//    init() {
////        self.arrayOfNumbersFaked = arrayOfNumbers
//    }
    
    
    
    //MARK: Infinity carousel service
    
    var sortedArrayOfCollection: [CollectionsOfQuote?] {
        return [fakedQuoteCollections.nextElementAfter(currentCollectionIndex + 1) ?? nil,
                fakedQuoteCollections.nextElementAfter(currentCollectionIndex) ?? nil,
                fakedQuoteCollections.elementByIndex(currentCollectionIndex) ?? nil,
                fakedQuoteCollections.elementBefore(currentCollectionIndex) ?? nil,
                
        ]
    }
    
    var sortedArrayOfCollectionFilled: [CollectionsOfQuote?] {
        return [
            fakedQuoteCollections.nextElementAfter(currentCollectionIndex) ?? nil,
            fakedQuoteCollections.elementByIndex(currentCollectionIndex) ?? nil,
            fakedQuoteCollections.elementBefore(currentCollectionIndex) ?? nil
        ]
    }
    
    func predictNextItemAppend<T: ChangeID>(lastItem: T?, realCollection: [T], _ appendIn: inout [T]) {
        if lastItem != nil {
            if var indexOfItem = realCollection.firstIndex(where: { $0.changeId == lastItem!.changeId }) {
                if indexOfItem == realCollection.count - 1 {
                    indexOfItem = 0
                    var nextElement = realCollection[indexOfItem]
                    nextElement.changeId = .init()
                    appendIn.append(nextElement)
                } else {
                    indexOfItem += 1
                    var nextElement = realCollection[indexOfItem]
                    nextElement.changeId = .init()
                    appendIn.append(nextElement)
                }
            }
        }
    }
    
    func predictNextItemInsert<T: ChangeID>(firstItem: T?, realCollection: [T], _ insertIn: inout [T]) {
        if firstItem != nil {
            if var indexOfItem = realCollection.firstIndex(where: { $0.changeId == firstItem!.changeId }) {
                if indexOfItem == 0 {
                    indexOfItem = realCollection.count - 1
                    var nextElement = realCollection[indexOfItem]
                    nextElement.changeId = .init()
                    insertIn.insert(nextElement, at: 0)
                } else {
                    indexOfItem -= 1
                    var nextElement = realCollection[indexOfItem]
                    nextElement.changeId = .init()
                    insertIn.insert(nextElement, at: 0)
                }
            }
        }
    }
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
    
    func shouldRemoveElements<T:ChangeID>(afterPassed: Int, collection: [T], currentIndex: Int) -> Bool {
        var passedCount = 0
        for index in collection.indices {
            if index < currentIndex {
                passedCount += 1
            }
        }
        return passedCount >= afterPassed
    }

    
    //MARK: Func for Infinity Carousel
    

    
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
    
//    func insertNextGradientAfter(_ lastItem: CustomRectangle, realCollection: [LinearGradient]) {
//        
//        if var itemIndex = realCollection.firstIndex(where: { $0 == lastItem.color }) {
//            if itemIndex == 0 {
//                itemIndex = realCollection.count - 1
//                arrayRectangles.insert(CustomRectangle(changeId: .init(), color: realCollection[itemIndex]), at: 0)
//            } else {
//                arrayRectangles.insert(CustomRectangle(changeId: .init(), color: realCollection[itemIndex - 1]), at: 0)
//            }
//        }
//    }

//    func appentNextGradientAfter(_ lastItem: CustomRectangle, realCollection: [LinearGradient]) {
//        
//        if var itemIndex = realCollection.firstIndex(where: { $0 == lastItem.color }) {
//            if itemIndex == realCollection.count - 1 {
//                itemIndex = 0
//                arrayRectangles.append(CustomRectangle(changeId: .init(), color: realCollection[itemIndex]))
//            } else {
//                itemIndex += 1
//                arrayRectangles.append(CustomRectangle(changeId: .init(), color: realCollection[itemIndex]))
//            }
//        }
//        
//    }
    
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

//    var sortedArrayOfNumbers: [CollectionModel?] {
//        return [arrayOfNumbersFaked.nextElementAfter(currentCollectionIndex + 1) ?? nil,
//                arrayOfNumbersFaked.nextElementAfter(currentCollectionIndex) ?? nil,
//                arrayOfNumbersFaked[currentCollectionIndex],
//                arrayOfNumbersFaked.elementBefore(currentCollectionIndex) ?? nil
//        ]
//    }
    
    var sortedArrayOfNumbersFilled: [CollectionModel?] {
        return [
            arrayOfNumbersFaked.nextElementAfter(currentCollectionIndex) ?? nil,
            arrayOfNumbersFaked[currentCollectionIndex],
            arrayOfNumbersFaked.elementBefore(currentCollectionIndex) ?? nil
        ]
    }
    
}


