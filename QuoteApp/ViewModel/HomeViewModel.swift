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
    
    
    @Published var quoteCollections: [QuoteCollection] = []
    
    @Published var fakedQuoteCollections: [QuoteCollection] = []
    
    @Published var arrayRectanglesFaked: [CustomRectangle] = []
    
    @Published var currentRectangle = 1
    
    @Published var currentCollectionIndex = 1
    
    @Published var text = ""
    
    @Published var playBridgeAnimation = true
    
    @Published var openCollection = false
    
    @Published var settingsMode = false
    
    @Published var draggOffset: CGFloat = 0
    
    
    
    
    
    //MARK: SwiftData service
    
    func currentIndexExist() -> Bool {
        return fakedQuoteCollections.elementByIndex(currentCollectionIndex) != nil
    }
    
    func collecitonIsEqualToCurrent(_ collection: QuoteCollection?) -> Bool {
        if currentIndexExist() {
            return fakedQuoteCollections[currentCollectionIndex] == collection
        } else {
            return false
        }
    }

    func fetchCollections() {
        let fetchDescriptor = FetchDescriptor<QuoteCollection>()
        
        //MARK: if write error the try this or just rename collection which has "ERROR"
//        ||
//        ||
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
        
            var sortedQuoteCollections: [QuoteCollection] {
                return quoteCollections.sorted {
                    $0.formattedDate < $1.formattedDate
                }
            }
            
            fakedQuoteCollections = sortedQuoteCollections
        
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
        
        let newCollection = QuoteCollection(name: "", quotes: [], id: .init(), datestamp: .now)
        
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

    var firstFourCollections: [QuoteCollection?] {
        return [fakedQuoteCollections.nextElementAfter(currentCollectionIndex + 1) ?? nil,
                fakedQuoteCollections.nextElementAfter(currentCollectionIndex) ?? nil,
                fakedQuoteCollections.elementByIndex(currentCollectionIndex) ?? nil,
                fakedQuoteCollections.elementBefore(currentCollectionIndex) ?? nil,
                
        ]
    }
    
    var firstThreeCollections: [QuoteCollection?] {
        return [
            fakedQuoteCollections.nextElementAfter(currentCollectionIndex) ?? nil,
            fakedQuoteCollections.elementByIndex(currentCollectionIndex) ?? nil,
            fakedQuoteCollections.elementBefore(currentCollectionIndex) ?? nil
        ]
    }
    
    func insertNextRectangleAfter(_ firstItem: CustomRectangle, realCollection: [CustomRectangle]) {
        
        if var itemIndex = realCollection.firstIndex(where: { $0.color == firstItem.color }) {
            if itemIndex == 0 {
                itemIndex = realCollection.count - 1
                arrayRectanglesFaked.insert(CustomRectangle(changeId: .init(), color: realCollection[itemIndex].color), at: 0)
            } else {
                arrayRectanglesFaked.insert(CustomRectangle(changeId: .init(), color: realCollection[itemIndex - 1].color), at: 0)
            }
        }
    }

    func appentNextRectangleAfter(_ lastItem: CustomRectangle, realCollection: [CustomRectangle]) {
        
        if var itemIndex = realCollection.firstIndex(where: { $0.color == lastItem.color }) {
            if itemIndex == realCollection.count - 1 {
                itemIndex = 0
                arrayRectanglesFaked.append(CustomRectangle(changeId: .init(), color: realCollection[itemIndex].color))
            } else {
                itemIndex += 1
                arrayRectanglesFaked.append(CustomRectangle(changeId: .init(), color: realCollection[itemIndex].color))
            }
        }
        
    }
    
    func shouldRemoveRectangles(passed: Int) -> Bool {
        var passedCount = 0
        for index in arrayRectanglesFaked.indices {
            if index < currentRectangle {
                passedCount += 1
            }
        }
        return passedCount >= passed
    }
    

}
