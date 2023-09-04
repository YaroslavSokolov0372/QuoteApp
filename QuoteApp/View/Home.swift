//
//  Home.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 30/08/2023.
//

import SwiftUI

struct Home: View {
    
    let arrayOfNumbers: [Int] = [07, 12, 32, 14, 42, 02, 01]
    
    @State var currentIndex: Int = 1
    
    var sortedArrayOfNumbers: [Int?] {
        return [arrayOfNumbers.nextElementAfter(currentIndex + 1) ?? nil,
                arrayOfNumbers.nextElementAfter(currentIndex) ?? nil,
                arrayOfNumbers[currentIndex],
                arrayOfNumbers.elementBefore(currentIndex) ?? nil
        ]
    }
    
    @State var draggOffset: CGFloat = 0
    
    @State var playAnimation: Bool = false
    
    var body: some View {

        
        
            
            ZStack {
                Rectangle()
                    .fill(.gray)
                    .frame(width: 500, height: 600)
                    .offset(x:  240,y: -140)
                    .rotationEffect(.degrees(2), anchor: .topTrailing)
                Rectangle()
                    .fill(.cyan)
                    .frame(width: 500, height: 600)
                    .offset(x:  210,y: -130)
                    .rotationEffect(.degrees(-7), anchor: .topTrailing)
                Rectangle()
                    .fill(.red)
                    .frame(width: 500, height: 600)
                    .offset(x:  170,y: -120)
                    .rotationEffect(.degrees(-11), anchor: .topTrailing)
                Rectangle()
                    .fill(.yellow)
                    .frame(width: 500, height: 600)
                    .offset(x:  130 ,y: -115)
                    .rotationEffect(.degrees(-17), anchor: .topTrailing)
                Rectangle()
                    .fill(.blue)
                    .frame(width: 500, height: 600)
                    .offset(x: 100 ,y: -95)
                    .rotationEffect(.degrees(-22), anchor: .topTrailing)
                
                Rectangle()
                    .fill(.brown)
                    .frame(width: 500, height: 600)
                    .offset(x: 60 ,y: -70)
                    .rotationEffect(.degrees(-26), anchor: .topTrailing)
                
                Rectangle()
                    .fill(.indigo)
                    .frame(width: 500, height: 600)
                    .offset(x: -5 ,y: -35)
                    .rotationEffect(.degrees(-32), anchor: .topTrailing)
                
                
  
                
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
                        
                        //                        ForEach(sortedArrayOfNumbers.indices, id: \.self) { num in
                        //                            if arrayOfNumbers[currentIndex] == sortedArrayOfNumbers[num] {
                        //                                VStack(alignment: .leading) {
                        //                                    Spacer()
                        //                                        .frame(height: 40)
                        //                                    Text(String(describing: arrayOfNumbers[num]))
                        //                                        .font(.system(size: 80))
                        //
                        //                                        .offset(y: draggOffset)
                        //                                        .gesture(
                        //                                            DragGesture(minimumDistance: 0.6)
                        //                                                .onChanged({ value in
                        //                                                    withAnimation {
                        //                                                        self.draggOffset = value.translation.height
                        //                                                        if draggOffset > 40 || draggOffset < -50 {
                        //                                                            self.draggOffset = 0
                        //                                                        }
                        //                                                    }
                        //                                                    print(draggOffset)
                        //                                                })
                        //                                                .onEnded({ value in
                        //                                                    withAnimation {
                        //                                                        self.draggOffset = 0
                        //                                                    }
                        //                                                })
                        //                                        )
                        //
                        //
                        //                                    Text("quotes from friends")
                        //                                }
                        //                                .frame(width: 200, height: 180)
                        ////                                .opacity(0)
                        //                            } else {
                        //                                VStack(alignment: .leading) {
                        //                                    Text(String(describing: arrayOfNumbers[num]))
                        //                                        .font(.system(size: 55))
                        //                                    Text("quotes from friends")
                        //                                }
                        //                                .frame(width: 200, height: 120)
                        //                            }
                        //
                        //                        }
                        
                        //                        Spacer()

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
                        })
                        .onEnded({ value in
                            if draggOffset > 26 {
                                withAnimation(.easeOut(duration: 0.15)){
                                    self.draggOffset = 0
                                    self.currentIndex += 1
                                    print(currentIndex)
                                }
                            } else {
                                withAnimation {
                                    self.draggOffset = 0
                                }
                            }
                        })
                )
            Text(number != nil ? "quotes from friends" : "")
            
            
        }
        .frame(height: arrayOfNumbers[currentIndex] == number ? 200 : 130)
        .offset(y: -25)
        .transition(.opacity)
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



 

//            HStack {
//                Image("Reference")
//                    .resizable()
////                    .scaledToFill()
////                    .frame(width: 500)
//                    .frame(width: 430 ,height: 1000)
//                    .rotationEffect(.degrees(-1))
//                    .offset(y: -27)
//            }
//            .opacity(0.7)
