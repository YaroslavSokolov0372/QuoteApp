//
//  CGFloatExtension.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 15/09/2023.
//

import Foundation
import SwiftUI


extension View {
    func offsetRectangle(rectangelIndexInArray: Int, currentRectangle: Int) -> some View {
        self
            .offset(x: offsetXRectangle(rectangelIndexInArray, currentRectangle: currentRectangle), y: offsetYRectangle(rectangelIndexInArray, currentRectangle: currentRectangle))
    }
}

extension View {
    func rotationEffectRectangle(rectangelIndexInArray: Int, currentRectangle: Int) -> some View {
        self
            .rotationEffect(.degrees(rotationDegrees(rectangelIndexInArray, currentRectangle: currentRectangle)), anchor: .topTrailing)
    }
}
func offsetXRectangle(_ rectangelIndexInArray: Int, currentRectangle: Int ) -> Double {
    
    var solution: Double = 0
    var numberToMinus: Double = 0
    var index = 0
    let difference = rectangelIndexInArray - currentRectangle
    
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

func offsetYRectangle(_ rectangelIndexInArray: Int, currentRectangle: Int) -> Double {
    
    
    var solution: Double = 0
    var index = 0
    var numberToMinus: Double = 0
    let difference = rectangelIndexInArray - currentRectangle
//    print(difference)
    
    if difference == 0 {
        
        solution = -45
        return solution
        
    } else if difference == 1 {
        
        solution = -90
        return solution
        
    } else if difference < 0 {
        
        return 700
        
    } else {
        
        while index != difference {
            numberToMinus += 10 * Double(index)
            index += 1
        }
        
        solution = -45 * Double(difference + 1)
        solution = solution + numberToMinus
        return solution
    }
}

func rotationDegrees(_ rectangelIndexInArray: Int, currentRectangle: Int) -> Double {
    var solution: Double = 0
    let defaultValue: Double = -33
    let indexMultiply: Double = Double(currentRectangle) * 6
    solution = defaultValue + (6 * Double(rectangelIndexInArray))
    solution -= indexMultiply
    if rectangelIndexInArray < currentRectangle {
        return -90
    } else {
        return solution
    }
}




