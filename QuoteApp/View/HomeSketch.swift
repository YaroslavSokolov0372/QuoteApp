//
//  HomeSketch.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 01/09/2023.
//

import SwiftUI

struct HomeSketch: View {
    let arrayOfNumbers: [Int] = [7, 6, 5, 4, 3, 2, 1]
    
    @State var currentIndex: Int = 0
    
    var sortedArrayOfNumbers: [Int?] {
        return [arrayOfNumbers.nextElementAfter(currentIndex + 1) ?? nil,
                arrayOfNumbers.nextElementAfter(currentIndex) ?? nil,
                arrayOfNumbers[currentIndex],
                arrayOfNumbers.elementBefore(currentIndex) ?? nil
                
        ]
    }
    
    @State var playAnimation: Bool = false
    @State var count: Int = 0
    @State private var fontSize = 32.0
    @State var draggOffset: CGFloat = 0

    var body: some View {
//        Button {
//            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
//                if fontSize == 72 { fontSize = 32 } else { fontSize = 72 }
//            }
//        } label: {
//            Text("32")
//                .animatableFont(size: fontSize)
//        }

        Button {
            self.playAnimation.toggle()
            
        } label: {
            Text(playAnimation ? "1" : "3")
                .font(.system(size: 100))
        }
        .animation(.easeInOut, value: playAnimation)
            
//            .onTapGesture {
//                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
//                    fontSize = 72
//                }
//            }
    }
}


struct HomeSketch_Previews: PreviewProvider {
    static var previews: some View {
        HomeSketch()
    }
}

struct AnimatableCustomFontModifier: ViewModifier, Animatable {
    var size: CGFloat

    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
}

// To make that easier to use, I recommend wrapping
// it in a `View` extension, like this:
extension View {
    func animatableFont(size: Double) -> some View {
        self.modifier(AnimatableCustomFontModifier(size: size))
    }
}

// An example View trying it out


