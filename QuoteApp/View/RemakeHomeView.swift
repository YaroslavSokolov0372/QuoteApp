//
//  RemakeHomeView.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 18/09/2023.
//

import SwiftUI

struct RemakeHomeView: View {
    
    @State var arrayRectangles : [Rectangles] = [ ]
    
    
    @StateObject var homeVM = HomeVM()
    @State var currentCollection = 1
    
    @State var rectangles = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    @State var fakeRectangles: [Int] = []
    
     func offsetXRectangle(num: Int, currentCollectioin: Int) -> CGFloat {
        let difference = num - currentCollectioin
        let multiply = CGFloat(difference) * 55
         if difference < 0 {
             return -500
         }
        
        
        return multiply + 55
    }
     func offsetYRectangle(num: Int, currentCollectioin: Int) -> CGFloat {
        let difference = num - currentCollectioin
        let multiply = CGFloat(difference) * -20
         if difference < 0 {
             return 250
         }
         
        
        return -85 + multiply
    }
    
    

    
    var body: some View {
        ZStack {
//            ForEach(homeVM.arrayOfNumbers.indices.reversed(), id: \.self) { num in
//                let indexForScroll = 0
//                Rectangle()
//                    .fill(gradients[num])
//                    .frame(width: 500, height: 600)
//                    .offsetRectangle(currentIndex: homeVM.currentCollectionIndex, num: num)
//                    .rotationEffect(.degrees(num < homeVM.currentCollectionIndex ? -90 : rotationDegrees(num: num, currentIndex: homeVM.currentCollectionIndex)), anchor: .topTrailing)
////                    .offsetRectangle(currentIndex: homeVM.currentCollectionIndex, num: num)
//                    .animation(.easeIn(duration: 0.33), value: homeVM.currentCollectionIndex)
//            }
            
            ForEach(fakeRectangles.indices, id: \.self) { num in
                //                if num < currentCollection {
                //                        Rectangle()
                //                        .fill(gradients[num])
                //                        .frame(width: 600, height: 600)
                //                        .offset(x: 10 + (CGFloat(num) * 70) , y: 405 + (CGFloat(num) * -20))
                //
                //                        .rotationEffect(.degrees(-90 + (Double(num) * 6)), anchor: .topTrailing)
//                                } else {
                                    Rectangle()
                                        .fill(gradients[num])
                                        .frame(width: 600, height: 600)
                                        .offset(
                                            x: num < currentCollection ? -500 : offsetXRectangle(num: num, currentCollectioin: currentCollection),
                //                            x: 55 + (CGFloat(num - currentCollection) * 55),
                //                            y: -85 + (CGFloat(num - currentCollection) * -20))
                                            y: num < currentCollection ? 250 : offsetYRectangle(num: num, currentCollectioin: currentCollection))
                                        .rotationEffect(.degrees(num < currentCollection ? -60 : -33 + (Double(num - currentCollection) * 6)), anchor: .topTrailing)
                                        .zIndex(8 - Double(num))
//                                }
//                if num == 1 {
//                    Rectangle()
//                        .fill(gradients[num])
//                        .frame(width: 600, height: 600)
//                        .offset(x: -500 + (CGFloat(num - currentCollection) * 55),
//                                y: 250 + (CGFloat(num - currentCollection) * -20))
//                        .rotationEffect(.degrees(-60 + (Double(num - currentCollection) * 6)), anchor: .topTrailing)
//                }
            }
                Button {

                    withAnimation(.default.speed(1)) {
                        withAnimation {
                            currentCollection += 1
                            print(currentCollection)
                        }
                    }

                } label: {
                    Text("+1")
                }
                .zIndex(20)

        }
        .onAppear {
            fakeRectangles.append(contentsOf: rectangles)
            if let firstRectangle = rectangles.first, let lastReactangle = rectangles.last {
                fakeRectangles.append(firstRectangle)
                fakeRectangles.insert(lastReactangle, at: 0)
                print(fakeRectangles)
            }
        }
    }
}

struct RemakeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RemakeHomeView()
    }
}
