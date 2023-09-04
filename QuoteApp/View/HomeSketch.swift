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
    @Namespace var animation
    


    
    @State var playAnimation: Bool = false
    @State var count: Int = 0
    @State private var fontSize = 32.0
    @State var draggOffset: CGFloat = 0
    @State var offsetOfCurrentIndex: CGFloat = 0
    
    @State var mainnumber: [Int] = [3, 4]

    var body: some View {
        VStack {
            ForEach(sortedArrayOfNumbers, id: \.self) { num in
                //                NumberView(num, currentIndex: currentIndex)
                //                    .offset(y: -330)
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: arrayOfNumbers[currentIndex] == num ? 40 : 0)
                    VStack {
                        Text(num != nil ? String(describing: num!) : "")
                            .font(.system(size: arrayOfNumbers[currentIndex] == num ? 100 : 70))
                            .transition(.opacity)

                        Text(num != nil ? "quotes from friends" : "")

                    }
                        .offset(y: arrayOfNumbers[currentIndex] == num ? offsetOfCurrentIndex : 0)
                        .gesture(
                            DragGesture(minimumDistance: 0.6)
                                .onChanged({ value in
                                    self.offsetOfCurrentIndex = value.translation.height / 3.5
                                    playAnimation = false
                                })
                                .onEnded({ value in
                                    if offsetOfCurrentIndex > 26 {
                                        withAnimation(.easeOut(duration: 0.25)){
                                            self.offsetOfCurrentIndex = 0
                                            self.currentIndex += 1
                                            print(currentIndex)
                                        }
                                    } else {
                                        withAnimation {
                                            self.offsetOfCurrentIndex = 0
                                        }
                                    }
                                })
                        )

//                        .matchedGeometryEffect(id: num.self, in: animation)

                }


//                .offset(y: -330)

//                .offset(y: Double(currentIndex) * 130)
//                .transition(.opacity)


            }
        }
        .frame(maxWidth: 100, maxHeight: 800)


        VStack {
            ForEach(arrayOfNumbers.reversed(), id: \.self) { num in
                Text(String(num))
                    .font(.system(size: arrayOfNumbers[currentIndex] == num ? 100 : 50))
                    .offset(y: arrayOfNumbers[currentIndex] == num ? offsetOfCurrentIndex : 0)

                    .gesture(
                        DragGesture(minimumDistance: 0.6)
                            .onChanged({ value in
                                self.offsetOfCurrentIndex = value.translation.height
                                playAnimation = false
                            })
                            .onEnded({ value in
                                if offsetOfCurrentIndex > 26 {
                                    withAnimation(.easeOut(duration: 0.5)){
                                        self.offsetOfCurrentIndex = 0
                                        self.currentIndex += 1
                                        print(currentIndex)
                                    }
                                } else {
                                    withAnimation {
                                        self.offsetOfCurrentIndex = 0
                                    }
                                }
                            })
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(y: 60 * Double(currentIndex))


        VStack {
            Text("3")
                .font(currentIndex > 0 ? .system(size: 100) : .system(size: 60))
            Text("4")
                .font(currentIndex <= 0 ? .system(size: 100) : .system(size: 60))
                .offset(y: offsetOfCurrentIndex)
                .gesture(
                    DragGesture(minimumDistance: 0.6)
                        .onChanged({ value in
                            self.offsetOfCurrentIndex = value.translation.height
                            playAnimation = false
                        })
                        .onEnded({ value in
                            if offsetOfCurrentIndex > 26 {
                                withAnimation(.easeOut(duration: 0.5)){
                                    self.offsetOfCurrentIndex = 0
                                    self.currentIndex += 1
                                    print(currentIndex)
                                }
                            } else {
                                withAnimation {
                                    self.offsetOfCurrentIndex = 0
                                }
                            }
                        })
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(y: 80 * Double(currentIndex))
        
//        VStack {
//            ForEach(arrayOfNumbers.reversed(), id: \.self) { num in
//                NumberView(num, currentIndex: currentIndex)
//                    .offset(y: -300)
//            }
//
//        }
//        .frame(width: 50, height: 50)
        
    }
    
    @ViewBuilder
    func NumberView(_ number: Int, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 40)
            Text(String(describing: number))
                .font(.system(size: arrayOfNumbers[currentIndex] == number ? 100 : 70))
                .offset(y: arrayOfNumbers[currentIndex] == number ? offsetOfCurrentIndex : 0)
                .gesture(
                    DragGesture(minimumDistance: 0.6)
                        .onChanged({ value in
                            self.offsetOfCurrentIndex = value.translation.height
                            playAnimation = false
                        })
                        .onEnded({ value in
                            if offsetOfCurrentIndex > 26 {
                                withAnimation(.easeOut(duration: 0.3)){
                                    self.offsetOfCurrentIndex = 0
                                    self.currentIndex += 1
                                    print(currentIndex)
                                }
                            } else {
                                withAnimation {
                                    self.offsetOfCurrentIndex = 0
                                }
                            }
                        })
                )
        }
        .offset(y: Double(currentIndex) * 130)
        .transition(.opacity)
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




