//
//  GradientColors.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 09/09/2023.
//

import Foundation
import SwiftUI


var gradients1: [LinearGradient] = [LinearGradient(
                                   stops: [
                                   Gradient.Stop(color: Color(red: 0.86, green: 0.82, blue: 0.76), location: 0.00),
                                   Gradient.Stop(color: Color(red: 0.73, green: 0.88, blue: 0.89), location: 1.00),
                                   ],
                                   startPoint: UnitPoint(x: 0.54, y: -0.01),
                                   endPoint: UnitPoint(x: 0.54, y: 0.99)
                                   ),
                                    //MARK: - 2
                                   LinearGradient(
                                   stops: [
                                   Gradient.Stop(color: Color(red: 0.84, green: 0.75, blue: 0.73), location: 0.00),
                                   Gradient.Stop(color: Color(red: 0.86, green: 0.81, blue: 0.58), location: 1.00),
                                   ],
                                   startPoint: UnitPoint(x: 0.5, y: 0),
                                   endPoint: UnitPoint(x: 0.5, y: 1)
                                   ),
                                    //MARK: - 3
                                   LinearGradient(
                                   stops: [
                                   Gradient.Stop(color: Color(red: 0.85, green: 0.89, blue: 0.75), location: 0.00),
                                   Gradient.Stop(color: Color(red: 0.77, green: 0.9, blue: 0.89), location: 1.00),
                                   ],
                                   startPoint: UnitPoint(x: 0.5, y: 0),
                                   endPoint: UnitPoint(x: 0.5, y: 1)
                                   ),
                                    //MARK: - 4
                                   LinearGradient(
                                   stops: [
                                   Gradient.Stop(color: Color(red: 0.81, green: 0.87, blue: 0.82), location: 0.00),
                                   Gradient.Stop(color: Color(red: 0.92, green: 0.95, blue: 0.94), location: 0.49),
                                   Gradient.Stop(color: Color(red: 0.76, green: 0.87, blue: 0.87), location: 1.00),
                                   ],
                                   startPoint: UnitPoint(x: 0.5, y: 0),
                                   endPoint: UnitPoint(x: 0.5, y: 1)
                                   ),
                                    //MARK: - 5
                                   LinearGradient(
                                   stops: [
                                   Gradient.Stop(color: Color(red: 0.91, green: 0.85, blue: 0.75), location: 0.00),
                                   Gradient.Stop(color: Color(red: 0.91, green: 0.81, blue: 0.76), location: 1.00),
                                   ],
                                   startPoint: UnitPoint(x: 0.5, y: 0),
                                   endPoint: UnitPoint(x: 0.5, y: 1)
                                   ),
                                    //MARK: - 6
                                   LinearGradient(
                                   stops: [
                                   Gradient.Stop(color: Color(red: 0.89, green: 0.85, blue: 0.79), location: 0.00),
                                   Gradient.Stop(color: Color(red: 0.8, green: 0.87, blue: 0.84), location: 1.00),
                                   ],
                                   startPoint: UnitPoint(x: 0.5, y: 0),
                                   endPoint: UnitPoint(x: 0.5, y: 1)
                                   ),
                                    //MARK: - 7
                                   LinearGradient(
                                   stops: [
                                   Gradient.Stop(color: Color(red: 1, green: 0.89, blue: 0.73), location: 0.00),
                                   Gradient.Stop(color: Color(red: 0.5, green: 0.86, blue: 0.88), location: 1.00),
                                   ],
                                   startPoint: UnitPoint(x: 0.5, y: 0),
                                   endPoint: UnitPoint(x: 0.5, y: 1)
                                   ),
                                    //MARK: - 8
                                   LinearGradient(
                                   stops: [
                                   Gradient.Stop(color: Color(red: 1, green: 0.73, blue: 0.73), location: 0.00),
                                   Gradient.Stop(color: Color(red: 0.65, green: 0.96, blue: 1), location: 1.00),
                                   ],
                                   startPoint: UnitPoint(x: 0.5, y: 0),
                                   endPoint: UnitPoint(x: 0.5, y: 1)
                                   ),
                                ]

var gradients: [LinearGradient] = [
    LinearGradient(colors: [Color("Color7"), Color("Color8")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color9"), Color("Color10")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color11"), Color("Color12")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color13"), Color("Color14")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color15"), Color("Color16")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color17"), Color("Color16")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color9"), Color("Color10")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color11"), Color("Color12")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color13"), Color("Color14")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color15"), Color("Color16")], startPoint: .topLeading, endPoint: .bottomTrailing),
    LinearGradient(colors: [Color("Color17"), Color("Color16")], startPoint: .topLeading, endPoint: .bottomTrailing)
]




