//
//  Home.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 30/08/2023.
//

import SwiftUI

struct Home: View {
    
    let arrayOfNumbers: [Int] = [07, 12, 32, 14, 42, 02, 01]
    
    @State var currentIndex: Int = 0
    @State var draggOffset: CGFloat = 0
    @State var playAnimation: Bool = false
    
    
    
    var intRandom = Int.random(in: 0...6)
    var colors: [Color] = [.indigo, .brown, .orange, .red, .green, .gray, .blue]
    
    
    var sortedArrayOfNumbers: [Int?] {
        return [arrayOfNumbers.nextElementAfter(currentIndex + 1) ?? nil,
                arrayOfNumbers.nextElementAfter(currentIndex) ?? nil,
                arrayOfNumbers[currentIndex],
                arrayOfNumbers.elementBefore(currentIndex) ?? nil
        ]
    }
    
//    func offsetXRectangle(num: Int, curerntIndex: Int ) -> Double {
//        var solution: Double = 0
//        var numberToMinus: Double = 0
//        var index = 0
//        let reactNum = num - currentIndex
//
//        if reactNum == 0 {
//
//            return 0
//        } else if reactNum == 1 {
//            return 70
//        } else {
//            solution = 70 * Double(num)
//            while index != num {
//                numberToMinus += Double(index) * 10
//                index += 1
//            }
//            solution -= numberToMinus
//            return solution
//        }
//    }
    
    func offsetXRectangle(num: Int, curerntIndex: Int ) -> Double {
        var solution: Double = 0
        var numberToMinus: Double = 0
        var index = 0
        let reactNum = num - currentIndex
        
        if reactNum == 0 {
            return 0
        } else if reactNum == 1 {
            return 70
        } else if reactNum < 0 {
            return -400
        } else {
            solution = 70 * Double(reactNum)
            while index != reactNum {
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
        let reactNum = num - currentIndex
        print(reactNum)
        
        if reactNum == 0 {
            solution = -45
//            print("solution to Y -", solution)
            return solution
        } else if reactNum == 1 {
            solution = -90
//            print("solution to Y -", solution)
            return solution
        } else if reactNum < 0 {
            return 700
        }
        else {
                
            while index != reactNum {
                numberToMinus += 10 * Double(index)
                index += 1
            }
            solution = -45 * Double(reactNum + 1)
//            print("solution to Y -", solution * numberToMinus)
            solution = solution + numberToMinus
//            print(solution)
            return solution
//            solution + numberToMinus
        }
        
    }
    
    func rotationDegrees(num: Int ,currentIndex: Int) -> Double {
        var solution: Double = 0
        let defaultValue: Double = -33
        let indexMultiply: Double = Double(currentIndex) * 6
        solution = defaultValue + (6 * Double(num))
        solution -= indexMultiply
//        print("degrees -", solution)
        return solution
    }
    
    var body: some View {

            ZStack {
                ForEach(arrayOfNumbers.indices.reversed(), id: \.self) { num in
                    
                        Rectangle()
                            .fill(colors[num])
//                            .tag(num)
                            .frame(width: 500, height: 600)
                            .offset(x: offsetXRectangle(num: num, curerntIndex: currentIndex), y: offsetYRectangle(num: num, currentIndex: currentIndex))
//                            .rotationEffect(.degrees(-33 + (6 * Double(num))), anchor: .topTrailing)
//                            .rotationEffect(.degrees((currentIndex - 1) == num ? -0 : 0), anchor: .trailing)
//                            .rotationEffect(.degrees(num < currentIndex ? -45 : 0), anchor: .trailing)
//                            .rotationEffect(.degrees(num < currentIndex ? -30 : 0), anchor: .top)
                            .rotationEffect(.degrees(num < currentIndex ? -90 : rotationDegrees(num: num, currentIndex: currentIndex)), anchor: .topTrailing)
//                            .offset(x: num < currentIndex ? 130 : 0 ,y: num < currentIndex ? 600 : 0)
//                            .offset(y: num < currentIndex ? 300 : 0)
                    
                    
                        
                }

                //MARK: -Title and MenuBar
                HStack {
                    VStack {
                        VStack {
                            Text("My Quotes")
                                .font(.system(size: 40))
                                .bold()
                                .padding(.leading, 30)
                            
                            Spacer()
                        }
                        .frame(height: 150)
                            VStack {
                                ForEach(sortedArrayOfNumbers, id: \.self) { num in
                                    NumberView(num, currentIndex: currentIndex)
                                }
                            }
                            .frame(height: 600)
                        }
                        .padding(.top, 20)
                        .frame(width: 260)
                        .offset(x: 10)
                        
                    VStack {
                        Text("ManuButton")
                        
                        Spacer()
                    }
                }
            }
        }
    
    
    @ViewBuilder
    func NumberView(_ number: Int?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Spacer()
//                .frame(height: 40)
            Text(number != nil ? String(describing: number!) : "")
                .font(.system(size: arrayOfNumbers[currentIndex] == number ? 100 : 70))
                .offset(y: arrayOfNumbers[currentIndex] == number ? draggOffset : 0)
                .gesture(
                    DragGesture(minimumDistance: 0.6)
                        .onChanged({ value in
                            self.draggOffset = value.translation.height / 3.5
                            playAnimation = false
                            print(draggOffset)
                        })
                        .onEnded({ value in
                            if draggOffset > 26 {
                                withAnimation(.easeOut(duration: 0.35)){
                                    self.draggOffset = 0
                                    self.currentIndex += 1
//                                    print(currentIndex)
                                }
                            } else if draggOffset < -20 {
                                withAnimation(.easeOut(duration: 0.2)){
                                    self.draggOffset = 0
                                    self.currentIndex -= 1
//                                    print(currentIndex)
                                }
                            }
                            else {
                                withAnimation {
                                    self.draggOffset = 0
                                }
                            }
                        })
                )
            Text(number != nil ? "quotes from friends" : "")
        }
        .frame(height: arrayOfNumbers[currentIndex] == number ? 200 : 130)
        .offset(y: -30)
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





//                Rectangle()
//                    .fill(.gray)
//                    .frame(width: 500, height: 600)
//                    .offset(x:  240,y: -130)
//                    .rotationEffect(.degrees(3), anchor: .topTrailing)
//                Rectangle()
//                    .fill(.cyan)
//                    .frame(width: 500, height: 600)
//                    .offset(x:  180,y: -130)
//                    .rotationEffect(.degrees(-3), anchor: .topTrailing)
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 500, height: 600)
//                    .offset(x:  150,y: -125)
//                    .rotationEffect(.degrees(-9), anchor: .topTrailing)
//                Rectangle()
//                    .fill(.yellow)
//                    .frame(width: 500, height: 600)
//                    .offset(x:  130 ,y: -115)
//                    .rotationEffect(.degrees(-15), anchor: .topTrailing)
//                Rectangle()
//                    .fill(.blue)
//                    .frame(width: 500, height: 600)
//                    .offset(x: 100 ,y: -100)
//                    .rotationEffect(.degrees(-21), anchor: .topTrailing)
//
//                Rectangle()
//                    .fill(.brown)
//                    .frame(width: 500, height: 600)
//                    .offset(x: 60 ,y: -80)
//                    .rotationEffect(.degrees(-27), anchor: .topTrailing)
//
//                Rectangle()
//                    .fill(.indigo)
//                    .frame(width: 500, height: 600)
//                    .offset(x: 0 ,y: -45)
//                    .rotationEffect(.degrees(-33), anchor: .topTrailing)





//MARK: - last the I used is down one

//                Rectangle()
//                    .fill(.gray)
//                    .frame(width: 500, height: 600)
//                    .offset(x:  270, y: -165)
//                    .rotationEffect(.degrees(3), anchor: .topTrailing)
//                Rectangle()
//                    .fill(.cyan)
//                    .frame(width: 500, height: 600)
//                    .offset(x:  250, y: -170)
//                    .rotationEffect(.degrees(-3), anchor: .topTrailing)
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 500, height: 600)
//                    .offset(x:  220, y: -165)
//                    .rotationEffect(.degrees(-9), anchor: .topTrailing)
//                Rectangle()
//                    .fill(.yellow)
//                    .frame(width: 500, height: 600)
//                    .offset(x:  180 , y: -150)
//                    .rotationEffect(.degrees(-15), anchor: .topTrailing)
//                Rectangle()
//                    .fill(.blue)
//                    .frame(width: 500, height: 600)
//                    .offset(x: 130 , y: -125)
//                    .rotationEffect(.degrees(-21), anchor: .topTrailing)
//
//                Rectangle()
//                    .fill(.brown)
//                    .frame(width: 500, height: 600)
//                    .offset(x: 70 , y: -90)
//                    .rotationEffect(.degrees(-27), anchor: .topTrailing)
//
//                Rectangle()
//                    .fill(.indigo)
//                    .frame(width: 500, height: 600)
//                    .offset(x: 0 , y: -45)
//                    .rotationEffect(.degrees(-33), anchor: .topTrailing)
