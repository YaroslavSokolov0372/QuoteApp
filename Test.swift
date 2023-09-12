//
//  Test.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 09/09/2023.
//

import SwiftUI

struct Test: View {
    @State var shouldChange: Bool = false
    var elemnts: [Int] = [3, 4, 1]
    @State var offset :CGFloat = 0
    
    let arrayOfNumbers: [Int] = [07, 12, 32, 14, 42, 02, 01]
    @State var currentIndex = 0
    @State var draggOffset: CGFloat = 0
    @State var changeFont: Bool = false
    
    var gri = LinearGradient(colors: [Color("Color7"), Color("Color8")], startPoint: .topLeading, endPoint: .bottomTrailing)
    var gri2 = LinearGradient(colors: [Color("Color9"), Color("Color10")], startPoint: .topLeading, endPoint: .center)
    var gri3 = LinearGradient(colors: [Color("Color11"), Color("Color12")], startPoint: .topLeading, endPoint: .center)
    var gri4 = LinearGradient(colors: [Color("Color13"), Color("Color14")], startPoint: .topLeading, endPoint: .center)
    var gri5 = LinearGradient(colors: [Color("Color15"), Color("Color16")], startPoint: .topLeading, endPoint: .center)
    var gri6 = LinearGradient(colors: [Color("Color17"), Color("Color16")], startPoint: .topLeading, endPoint: .center)
    
    var sortedArrayOfNumbers: [Int?] {
        return [
//            arrayOfNumbers.nextElementAfter(currentIndex + 1) ?? nil,
                arrayOfNumbers.nextElementAfter(currentIndex) ?? nil,
                arrayOfNumbers[currentIndex],
                arrayOfNumbers.elementBefore(currentIndex) ?? nil
        ]
    }
    var sortedArrayOfNumbers2: [Int?] {
        return [
            arrayOfNumbers.nextElementAfter(currentIndex + 1) ?? nil,
                arrayOfNumbers.nextElementAfter(currentIndex) ?? nil,
                arrayOfNumbers[currentIndex],
                arrayOfNumbers.elementBefore(currentIndex) ?? nil
        ]
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(sortedArrayOfNumbers2, id: \.self) { num in
                    VStack {
                        Text(num != nil ? String(num!) : "")
                            .customFont(50, .halenoirOutline)
                            .opacity(num == arrayOfNumbers[currentIndex] ? 0 : 1)
                            
                    }
                    .frame(width: 100, height: 200)
                    .offset(y: -100)
                    .transition(.move(edge: .bottom))
                }
            }
            VStack {
                ForEach(sortedArrayOfNumbers, id: \.self) { num in
                    VStack {
                        Text(num != nil ? String(num!) :  "")
                            .customFont(num == arrayOfNumbers[currentIndex] ? 70 : 50, .halenoir)
                            .offset(y: num == arrayOfNumbers[currentIndex] ? draggOffset : 0)
                            .opacity(num == arrayOfNumbers[currentIndex] ? 1 : 0)
                            .gesture(
                                DragGesture(minimumDistance: 0.6)
                                    .onChanged({ value in
                                        self.draggOffset = value.translation.height / 3.5
                                        //                                    playAnimation = false
                                        //                                    print(draggOffset)
                                    })
                                    .onEnded({ value in
                                        if draggOffset > 26 {
                                            withAnimation(.easeOut(duration: 0.25)){
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
                    }
                    .frame(width: 100, height: 200)
                }
                
            }
            
            Rectangle()
                .fill(gri)
                .frame(width: 200, height: 200)
                
            
        }
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
