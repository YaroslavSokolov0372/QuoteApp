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
    
    @Published var currentCollectionIndex = 1
    
    @Published var quoteCollections: [QuoteCollections] = []
    
    @Published var fakedQuoteCollections: [QuoteCollections] = []
    
    @Published var currentRectangle = 1
    
    @Published var arrayRectangles: [CustomRectangle] = []
    
    
    @Published var text = ""
    
    @Published var openCollection = false
    
    @Published var settingsMode = false
    
    @Published var draggOffset: CGFloat = 0
    
    
    //MARK: SwiftData service
    
    func currentIndexExist() -> Bool {
        return fakedQuoteCollections.elementByIndex(currentCollectionIndex) != nil
    }
    
    func collecitonIsEqualToCurrent(_ collection: QuoteCollections?) -> Bool {
        if currentIndexExist() {
            return fakedQuoteCollections[currentCollectionIndex] == collection
        } else {
            return false
        }
    }

    func fetchCollections() {
        let fetchDescriptor = FetchDescriptor<QuoteCollections>()
        
        
//        quoteCollections = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
        
        if modelContext != nil {
            do {
                quoteCollections = try modelContext!.fetch(fetchDescriptor)
            } catch {
                print("faile to fetch collections of Quote")
            }
        }
    }
    
    func setUpFakedCollections() {
        
            var sortedQuoteCollections: [QuoteCollections] {
                return quoteCollections.sorted {
                    $0.formattedDate < $1.formattedDate
                }
            }
            
            fakedQuoteCollections = sortedQuoteCollections
        
        
//        if fakedQuoteCollections.count == 1 {
//            
////            for _ in 0...4 {
////                if let element = fakedQuoteCollections.first {
////                    element.changeId = .init()
////                    fakedQuoteCollections.append(element)
////                }
////            }
//            
//            
//        } else if fakedQuoteCollections.count == 2 {
//            
//        } else if fakedQuoteCollections.count == 3 {
//            
//        } else {
//            
//        }
        
//        if fakedQuoteCollections.count >= 4 {
//            for collection in sortedQuoteCollections {
//                collection.changeId = .init()
//                fakedQuoteCollections.append(collection)
//            }
//        }
        
        }
    
    func updateData() {
        
        if currentIndexExist() {
            fakedQuoteCollections[currentCollectionIndex].name = self.text
            try? modelContext?.save()
            
            fetchCollections()
            
            setUpFakedCollections()
            
            print("current index exist, updateed data")
        }
    }
    
    func prepareForSettingsMode() {
        if currentIndexExist() {
            self.text = fakedQuoteCollections[currentCollectionIndex].name
            print("current index exist, prepared data")
        }
    }
    
    func deleteCollection() {
        
        //        if let indexItem = quoteCollections.firstIndex(where: { $0.formattedDate == fakedQuoteCollections[currentCollectionIndex].formattedDate }) {
        //
        //            modelContext?.delete(quoteCollections[indexItem])
        //            try? modelContext?.save()
        //
        //            fetchCollections()
        //
        //            setUpFakedCollections()
        //
        //            if fakedQuoteCollections.count < 1 {
        //                currentCollectionIndex = 0
        //            } else if currentCollectionIndex == fakedQuoteCollections.count {
        //                currentCollectionIndex -= 1
        //            }
        //
        //            text = ""
        //            prepareForSettingsMode()
        //
        
        //        }
        
        if currentIndexExist() {
            modelContext?.delete(fakedQuoteCollections[currentCollectionIndex])
            
            try? modelContext?.save()
            
            fetchCollections()
            
            setUpFakedCollections()
            
            if fakedQuoteCollections.count < 1 {
                currentCollectionIndex = 0
            } else if currentCollectionIndex == fakedQuoteCollections.count {
                currentCollectionIndex -= 1
            }
            
            text = ""
            prepareForSettingsMode()
        }
        
        print(currentCollectionIndex)
        
        
    }
    
    func createNewCollection() {
        
        let newCollection = QuoteCollections(name: "", quotes: [], id: .init(), datestamp: .now)
        
        modelContext?.insert(newCollection)
        try? modelContext?.save()
        
        fetchCollections()
        
        setUpFakedCollections()
        
        
        if  fakedQuoteCollections.count == 2 {
            currentCollectionIndex = 1
        } else if fakedQuoteCollections.count > 2 {
            currentCollectionIndex = fakedQuoteCollections.count - 1
        }
        
        
        text = ""
        settingsMode.toggle()

        print("current index -", currentCollectionIndex)
        print("count of collections -", fakedQuoteCollections.count)

        
    }
    
    

    
    
    
    
    
    
    
    

    
    
    
    

    

    
    
    
    //MARK: Infinity carousel service
    
    var firstFourCollections: [QuoteCollections?] {
        return [fakedQuoteCollections.nextElementAfter(currentCollectionIndex + 1) ?? nil,
                fakedQuoteCollections.nextElementAfter(currentCollectionIndex) ?? nil,
                fakedQuoteCollections.elementByIndex(currentCollectionIndex) ?? nil,
                fakedQuoteCollections.elementBefore(currentCollectionIndex) ?? nil,
                
        ]
    }
    
    var firstThreeCollections: [QuoteCollections?] {
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
    
    //MARK: - Temporary collection in type of Int
    
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


