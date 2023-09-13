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
    
    @State var openCollection: Bool = false
    
    
    
    var intRandom = Int.random(in: 0...6)
    var colors: [Color] = [.indigo, .brown, .orange, .red, .green, .gray, .blue]
    
    var sortedArrayOfNumbers: [Int?] {
        return [arrayOfNumbers.nextElementAfter(currentIndex + 1) ?? nil,
                arrayOfNumbers.nextElementAfter(currentIndex) ?? nil,
                arrayOfNumbers[currentIndex],
                arrayOfNumbers.elementBefore(currentIndex) ?? nil
        ]
    }
    
    var sortedArrayOfNumbers3: [Int?] {
        return [
//            arrayOfNumbers.nextElementAfter(currentIndex + 1) ?? nil,
                arrayOfNumbers.nextElementAfter(currentIndex) ?? nil,
                arrayOfNumbers[currentIndex],
                arrayOfNumbers.elementBefore(currentIndex) ?? nil
        ]
    }
    
    
    
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
            return solution
        } else if reactNum == 1 {
            solution = -90
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
//        print("degrees -", solution)
        return solution
    }
    
    
    var body: some View {

            ZStack {
                //MARK: -Rectangles
                ForEach(arrayOfNumbers.indices.reversed(), id: \.self) { num in
                        Rectangle()
//                            .fill(colors[num])
                        .fill(gradients[num])
//                        .fill(gri)
                            .frame(width: 500, height: 600)
                            .offset(x: offsetXRectangle(num: num, curerntIndex: currentIndex), y: offsetYRectangle(num: num, currentIndex: currentIndex))
                            .rotationEffect(.degrees(num < currentIndex ? -90 : rotationDegrees(num: num, currentIndex: currentIndex)), anchor: .topTrailing)
                            .animation(.easeIn(duration: 0.33), value: currentIndex)
//                            .rotationEffect(.degrees(currentIndex == num ? openCollection ? 170 : 0 : 0), anchor: .topTrailing)
//                            .frame(width: 600, height: 600)
//                            .offset(x: -240,y: 550)
//                            .rotationEffect(.degrees(170), anchor: .topTrailing)
//                            .offset(x: 220, y: 230)
                            
                            
    
                }

                //MARK: -QuotesCollections
                
                    
                    
                    VStack {
                        ForEach(sortedArrayOfNumbers, id: \.self) { num in
                            NumberViewOutlined(num, currentIndex: currentIndex)
                        }
                        .animation(.default.speed(1), value: currentIndex)

                    }
                    .offset(x: -30, y: 70)
                    VStack {
                        ForEach(sortedArrayOfNumbers3, id: \.self) { num in
                            NumberViewFilled(num, currentIndex: currentIndex)
                        }
                        .animation(.default.speed(1), value: currentIndex)

                    }
                    .offset(x: -30, y: 150)
                
                //MARK: -Title and MenuBar
                HStack {
                    VStack {
                        Text("My Quotes")
                            .customFont(37, .mono)
                            .padding(.leading, 50)
                        
                        Spacer()
                            .frame(height: 670)
                    }
                    .frame(width: 300)
                    
                    VStack {
                            Button {
                                
                            } label: {
                                Image("menuImage")
                                    .resizable()
                                    .frame(width: 30, height: 25)
                            }
                            .padding(.leading)
                            
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image("plusImage")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }
                        .padding(.trailing)
                        Spacer()
                            .frame(height: 170)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
        }
    
    
    @ViewBuilder
//    func NumberView(_ number: Int?, currentIndex: Int) -> some View {
//        VStack(alignment: .leading) {
//            Spacer()
////                .frame(height: 40)
//            Text(number != nil ? String(number!) : "")
////                .font(.system(size: arrayOfNumbers[currentIndex] == number ? 100 : 70))
//
//                .customFont(arrayOfNumbers[currentIndex] == number ? 90 : 70,  arrayOfNumbers[currentIndex] == number ? .halenoir : .halenoirOutline)
//
//                .offset(y: arrayOfNumbers[currentIndex] == number ? draggOffset : 0)
//                .gesture(
//                    DragGesture(minimumDistance: 0.6)
//                        .onChanged({ value in
//                            self.draggOffset = value.translation.height / 3.5
//                            playAnimation = false
//                            print(draggOffset)
//                        })
//                        .onEnded({ value in
//                            if draggOffset > 26 {
//                                withAnimation(.easeOut(duration: 3.35)){
//                                    self.draggOffset = 0
//                                    self.currentIndex += 1
////                                    print(currentIndex)
//                                }
//                            } else if draggOffset < -20 {
//                                withAnimation(.easeOut(duration: 0.2)){
//                                    self.draggOffset = 0
//                                    self.currentIndex -= 1
////                                    print(currentIndex)
//                                }
//                            }
//                            else {
//                                withAnimation {
//                                    self.draggOffset = 0
//                                }
//                            }
//                        })
//                )
//            Text(number != nil ? "quotes from friends" : "")
//                .customFont(15, .mono)
//        }
//
//        .frame(height: arrayOfNumbers[currentIndex] == number ? 200 : 130)
//        .offset(y: -30)
//    }
    
    func NumberViewOutlined(_ number: Int?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Text(number != nil ? String(number!) : "")
                .customFont(70, .halenoirOutline)
            Text(number != nil ? "quotes from friends" : "")
                .customFont(15, .mono)
        }
        .opacity(number == arrayOfNumbers[currentIndex] ? 0 : 1)
        .frame(width: 200 ,height: arrayOfNumbers[currentIndex] == number ? 160 : 150)
    }
    
    func NumberViewFilled(_ number: Int?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Spacer()
            
            
            Text(number != nil ? String(number!) :  "")
                .customFont(number == arrayOfNumbers[currentIndex] ? 90 : 70, .halenoir)
                .offset(y: number == arrayOfNumbers[currentIndex] ? draggOffset : 0)
                
                .gesture(
                    DragGesture(minimumDistance: 0.6)
                        .onChanged({ value in
                            self.draggOffset = value.translation.height / 3.5
                            //                                    playAnimation = false
                            //                                    print(draggOffset)
                        })
                        .onEnded({ value in
                            if draggOffset > 26 {
//                                withAnimation(.easeOut(duration: 0.35)){
                                    self.draggOffset = 0
                                    self.currentIndex += 1
                                    //                                    print(currentIndex)
//                                }
                            } else if draggOffset < -20 {
//                                withAnimation(.easeOut(duration: 0.2)){
                                    self.draggOffset = 0
                                    self.currentIndex -= 1
                                    //                                    print(currentIndex)
//                                }
                            }
                            else {
                                withAnimation {
                                    self.draggOffset = 0
                                }
                            }
                        })
                )
                .onTapGesture {
                    print("hello world")
                    openCollection = true
                }
            Text(number != nil ? "quotes from friends" : "")
                .customFont(15, .mono)
        }
        .opacity(number == arrayOfNumbers[currentIndex] ? 1 : 0)
        .frame(width: 200, height: arrayOfNumbers[currentIndex] == number ? 160 : 150)
        
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
