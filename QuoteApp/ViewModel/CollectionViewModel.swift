//
//  CollectionViewModel.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 16/09/2023.
//

import Foundation
import SwiftUI
import SwiftData


class CollectionVM: ObservableObject {
    
    var modelContext: ModelContext?
    
    @Published var currentCollection: QuoteCollection
    
    @Published var quote = ""
    
    @Published var whomQuote = ""
    
    @Published var link = ""
    
    @Published var settingsMode = false
    
    @Published var currentIndex = 0
    
    @Published var wantToDelete = false
    
    @Published var draggOffset: CGFloat = 0
    
    @Published var playAnimation = false
    
    @Published var playDelayedOpacityAnimation = false
    
    @Published var playQuoteAnimation = false
    
    @Published var moreInfo = false
    
    var quotes: [Quote] {
        return currentCollection.quotes.sorted {
            $0.formattedDate < $1.formattedDate
        }
    }
    
    init(currentCollection: QuoteCollection, modelContext: ModelContext) {
        self.currentCollection = currentCollection
        self.modelContext = modelContext
        
    }
    
    func currentIndexExist() -> Bool {
        return quotes.elementByIndex(currentIndex) != nil
    }
    
    func updateData() {
        
        if currentIndexExist() {
            quotes[currentIndex].quote = self.quote
            quotes[currentIndex].whomQuote = self.whomQuote
            quotes[currentIndex].resource = self.link
            try? modelContext?.save()
            
            print("current index exist, updateed data")
        }
    }
    
    func prepareForSettingsMode() {
        if currentIndexExist() {
            self.quote = quotes[currentIndex].quote
            self.whomQuote = quotes[currentIndex].whomQuote
            self.link = quotes[currentIndex].resource
            print("current index exist, prepared data")
        }
    }
    
    func createQuote() {
        
        updateData()
        
        let quote = Quote(quote: "", whomQuote: "", datestamp: .now, resource: "")
        currentCollection.quotes.append(quote)
        
        try? modelContext?.save()
        
        
        if  currentCollection.quotes.count == 2 {
            currentIndex = 1
        } else if currentCollection.quotes.count > 2 {
            currentIndex = currentCollection.quotes.count - 1
        }
        
        self.quote = ""
        self.whomQuote = ""
        self.link = ""
        prepareForSettingsMode()

        print("current index after creating new one -", currentIndex)
        
    }
    
    func deleteQuote() {
        if currentIndexExist() {
            //            currentCollection.quotes.(at: currentIndex)
            if let indexToDelete = currentCollection.quotes.firstIndex(where: { $0.changeId == quotes[currentIndex].changeId}) {
                currentCollection.quotes.remove(at: indexToDelete)
                try? modelContext?.save()
                
                
                if currentCollection.quotes.count < 1 {
                    currentIndex = 0
                } else if currentIndex == currentCollection.quotes.count {
                    currentIndex -= 1
                }
            }
            
            prepareForSettingsMode()
            print("collection count after delete -", currentCollection.quotes.count)
            print("current index after delete -", currentIndex)
        }
    }
    
    func currentQuoteOffset() -> CGFloat {

        let distance = (CGFloat((currentCollection.quotes.count - 1) * 140))
        let reverse = CGFloat((currentIndex - (currentCollection.quotes.count - 1)) * 280)
        return distance + reverse
    }
    
}
