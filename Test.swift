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
    @State var playAnimation: Bool = false
    
    
    
    @Namespace var rectangle
    
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
    @State var delayedOpacityRectangle: Bool = false
    
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
            
            

            
//            Rectangle()
//                .fill(gri)
//                .frame(width: 600, height: 600)
//                .rotationEffect(.degrees(-33), anchor: .topTrailing)
//                .offset(x: -30, y: -90)
//                .matchedGeometryEffect(id: 1, in: rectangle)
//                .rotationEffect(.degrees(playAnimation ? 90 : 0))
//                .offset(x: playAnimation ? 170 : 0 ,y: playAnimation ? -300 : 0)
                
            ForEach(sortedArrayOfNumbers2.indices.reversed(), id: \.self) { num in
                Rectangle()
                    .fill(gri)
                    .frame(width: 600, height: 600)
                    .rotationEffect(.degrees(-33), anchor: .topTrailing)
                    .offset(x: -60, y: -100)
                    .rotationEffect(.degrees(playAnimation ? 83 : 0), anchor: .center)
                    .offset(x: playAnimation ? 150 : 0, y: playAnimation ? -300 : 0)
                    .rotationEffect(.degrees(Double(5 * num)), anchor: .center)
                    .opacity(1 - 0.25 * Double(num))
                    .opacity(num == 0 ? 1 : delayedOpacityRectangle ? 1 : 0)
            }
            
//            if playAnimation {
//                Rectangle()
//                    .fill(gri)
//                    .frame(width: 500, height: 600)
//                    .rotationEffect(.degrees(-50), anchor: .topTrailing)
//                //                    .offset(x: -30, y: -90)
//                    .matchedGeometryEffect(id: 1, in: rectangle)
//
//            }
            
            VStack {
                HStack {
                    Button {
                        withAnimation(.default.speed(1.2)){
                            playAnimation.toggle()
                        }
                    } label: {
                        Image("arrowImage")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .rotationEffect(.degrees(180))
                            
                    }
                    
                    Spacer()
                        .frame(width: 290)
                    
                    Button {
                        withAnimation(.default.speed(1.2)){
                            playAnimation.toggle()
                        }
                    } label: {
                        Image("moreImage")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(.top, 40)
                
                Spacer()
                
                
                
                HStack {
                    Button {
                        
                    } label: {
                        Image("shareImage")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.trailing, 50)
                    }
                    Button {
                        
                    } label: {
                        Image("trashImage")
                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .frame(width: 50, height: 50)
                            .frame(width: 40, height: 40)
                    }
                    Spacer()
                        .frame(width: 70)
                    
                    Text("1/12")
                        .customFont(18, .mono)
                        .offset(x: 50)
                }
                .padding()
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(.spring(dampingFraction: 1.0, blendDuration: 0.0)){
                    playAnimation.toggle()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.spring(dampingFraction: 1.0, blendDuration: 0.0).speed(0.4)) {
                    delayedOpacityRectangle = true
                }
            }
        }
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
