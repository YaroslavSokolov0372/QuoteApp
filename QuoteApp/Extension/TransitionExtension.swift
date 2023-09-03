//
//  TransitionExtension.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 03/09/2023.
//

import Foundation
import SwiftUI


extension AnyTransition {
    
//    static var toAccentNumber: AnyTransition {
//        AnyTransition.modifier(active: NumberModifier(fontSize: nil), identity: NumberModifier(fontSize: nil))
//
//    }
    
    static var fromAccentNumber: AnyTransition {
        AnyTransition.modifier(active: NumberModifier(fontSize: 70), identity: NumberModifier(fontSize: 120))
    }
}


struct NumberModifier: ViewModifier {
    var fontSize: CGFloat
    
    
    var animatableData: Double {
        get { fontSize }
        set { fontSize = newValue }
    }
    
//    init(fontSize: CGFloat) {
//        self.fontSize = fontSize
//    }
    
    func body(content: Content) -> some View {
        return content
            .font(.system(size: fontSize))
    }
}
