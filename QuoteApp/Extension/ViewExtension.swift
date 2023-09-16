//
//  CGFloatExtension.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 15/09/2023.
//

import Foundation
import SwiftUI


extension View {
    func offsetRectangle(currentIndex: Int, num: Int) -> some View {
        self
            .offset(x: offsetXRectangle(num: num, currentIndex: currentIndex), y: offsetYRectangle(num: num, currentIndex: currentIndex))
    }
}

extension View {
    func rotationEffectRectangle(currentIndex: Int, num: Int) -> some View {
        self
            .rotationEffect(.degrees(num < currentIndex ? -90 : rotationDegrees(num: num, currentIndex: currentIndex)), anchor: .topTrailing)
    }
}

 func offsetXRectangle(num: Int, currentIndex: Int ) -> Double {
var solution: Double = 0
var numberToMinus: Double = 0
var index = 0
let difference = num - currentIndex

if difference == 0 {
    return 0
} else if difference == 1 {
    return 70
} else if difference < 0 {
    return -400
} else {
    solution = 70 * Double(difference)
    while index != difference {
        numberToMinus += Double(index) * 10
        index += 1
    }
    solution -= numberToMinus
    return solution
}
}

 func offsetYRectangle(num: Int, currentIndex: Int) -> Double {
    
    
    var solution: Double = 0
    var index = 0
    var numberToMinus: Double = 0
    let difference = num - currentIndex
    print(difference)
    
    if difference == 0 {
        solution = -45
        return solution
    } else if difference == 1 {
        solution = -90
        return solution
    } else if difference < 0 {
        return 700
    }
    else {
        
        while index != difference {
            numberToMinus += 10 * Double(index)
            index += 1
        }
        solution = -45 * Double(difference + 1)
        solution = solution + numberToMinus
        return solution
    }
    
}

 func rotationDegrees(num: Int ,currentIndex: Int) -> Double {
    var solution: Double = 0
    let defaultValue: Double = -33
    let indexMultiply: Double = Double(currentIndex) * 6
    solution = defaultValue + (6 * Double(num))
    solution -= indexMultiply
    return solution
}
