//
//  Test.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 09/09/2023.
//

import SwiftUI

struct Test: View {
    
//    @Binding
    @Binding var shouldCloseQuoteView: Bool
    
    @State var playQuoteAnimation: Bool = false
    
    
    @State var shouldChange: Bool = false
    var elemnts: [Int] = [3, 4, 1]
    @State var offset :CGFloat = 0
    
    let arrayOfNumbers: [Int] = [07, 12, 32, 14, 42, 02, 01]
    @State var currentIndex = 0
    @State var draggOffset: CGFloat = 0
    @State var changeFont: Bool = false
    @State var playAnimation: Bool = false
    @State var playTextAnimation: Bool = false
    
    @State var moreInfo: Bool = false
    
    @State var text: String = "All the world's a stage, and all the men and women merely players"
    
    
    
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
                        shouldCloseQuoteView = false
//                        withAnimation(.default.speed(1.2)){
////                            playAnimation.toggle()
//                        }
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
                    
                
                VStack(alignment: .leading) {
                    Text(" '' ")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .offset(x: -20, y: 40)
                    TextField("Citate", text: $text, axis: .vertical)
                        .customFont(30, .mono)
                        .frame(width: 280, height: 280, alignment: .top)


                    
                    
                    
                    Text("SHAKESPEAR")
                        .customFont(14, .mono)
                        .foregroundColor(.black.opacity(0.5))
                        .offset(y: 10)
                        
                        
                    
                }
//                .frame(width: 280, height: 300)
                .offset(x: 20, y: -50)
                .opacity(playQuoteAnimation ? 1 : 0)
                .offset(y: playQuoteAnimation ? 0 : -30)
                
                
                VStack(alignment: .leading) {
                    Button {
                        moreInfo.toggle()

                    } label: {
                        HStack {
                            Text("INFO")
                                .customFont(17, .mono)
                                .foregroundColor(.white)
                            Image("arrowImage")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .frame(width: 17, height: 17)
                                .rotationEffect(.degrees(90))
                        }
                    }
                    .padding(4)
                    .padding(.horizontal, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                    )
                    .offset(y: moreInfo ? -20 : 130)
                    .animation(.spring(dampingFraction: 1, blendDuration: 0.0), value: moreInfo)
//                    .animation(.interactiveSpring(response: 0.4 ,dampingFraction: 2, blendDuration: 0.2), value: moreInfo)
//                    .animation(.easeInOut(duration: 0.3), value: moreInfo)
                    
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text("Date")
                        //                        .customFont(17, .halenoir)
                            .foregroundColor(.gray.opacity(0.4))
                            .padding(.bottom, 1)
                        HStack {
                            Text("03 MAR 2020")
                                .padding(.trailing, 20)
                            Text("12.52.03")
                        }
                        .customFont(13, .mono)
                    }
                    .opacity(moreInfo ? 1 : 0)
                    .animation(.easeIn(duration: moreInfo ? 0.5 : 0.2), value: moreInfo)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Resource")
                            .foregroundColor(.gray.opacity(0.4))
                            .padding(.bottom, 1)
                        Text("https.//abuk.com.ua/william-shakespeare")
                            .customFont(13, .mono)
                            .underline()
                    }
                    .opacity(moreInfo ? 1 : 0)
                    .padding(.top, 5)
                    .animation(.easeIn(duration: 0.5), value: moreInfo)
                }
                .offset(x: 30)

                
                HStack {
                    Button {
                        
                        
                    } label: {
                        Image("shareImage")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(.trailing, 50)
                    }
                    Button {
                        
                    } label: {
                        Image("trashImage")
                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .frame(width: 50, height: 50)
                            .frame(width: 35, height: 35)
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
                    playQuoteAnimation = true
                }
            }
        }
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test(
            shouldCloseQuoteView: .constant(false)
        )
    }
}
