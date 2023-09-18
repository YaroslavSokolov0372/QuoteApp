//
//  CollectionViewModel.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 16/09/2023.
//

import Foundation
import SwiftUI


class CollectionVM: ObservableObject {
    
    //MARK: Animaiton propreties
    @Published var playAnimation = false
    
    @Published var playDelayedOpacityAnimation = false
    
    @Published var playQuoteAnimation = false
    
    @Published var moreInfo = false
    
    
    
    
    
    //MARK: Properties for Model
    @Published var quote = "All the world's a stage, and all the men and women merely players"
    
    @Published var whomQuote = "SHAKESPEARE"
    
    @Published var link = "https://developer.apple.com/documentation/swiftui/openurlaction"
//    "https.//abuk.com.ua/william-shakespeare"
    
    @Published var settingsMode = false
    

    
    

    
    @Published var currentIndex = 0

    
    @Published var wantToDelete = false
    
    @Published var draggOffset: CGFloat = 0
    
    
    var quotes: [QuoteExample] = [QuoteExample(quote: "bla bla bla", whomQuote: "Van hog"),
                                  QuoteExample(quote: "All the world's a stage, and all the men and women merely players", whomQuote: "SHAKESPEAR"),
                                  QuoteExample(quote: "All the world's a,women merely players", whomQuote: "SHUPACHUPS")]
    
    
}
