//
//  RemakeHomeView.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 18/09/2023.
//

import SwiftUI

struct RemakeHomeView: View {
    
    @StateObject var homeVM = HomeVM()
    @State var currentCollection = 0
//  Dumau...
    @State var passedRectangles = 0
    
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
            
            ForEach(0..<8, id: \.self) { num in
                if num == 0 {
                    Rectangle()
                        .fill(gradients[num])
                        .frame(width: 600, height: 600)
                        .offset(x: 55, y: 500)
                        .rotationEffect(.degrees(-33 + (Double(num) * 6)), anchor: .topTrailing)
                        .opacity(currentCollection + 1 == num || currentCollection - 1 == num ? 1 : 0)
                } else {
                    Rectangle()
                        .fill(gradients[num])
                        .frame(width: 600, height: 600)
                        .offset(x: 55 + (CGFloat(num - 1) * 70) , y: -85 + (CGFloat(num - 1 - passedRectangles) * -20))
                        .rotationEffect(.degrees(-33 + (Double(num - 1 + passedRectangles) * 6)), anchor: .topTrailing)
                        .zIndex(8 - Double(num))
                }
            }
//            HStack(spacing: 40) {
                Button {
//                    homeVM.currentCollectionIndex += 1
                    withAnimation(.default.speed(1)) {
//                        homeVM.arrayOfNumbers.append(10)
                        passedRectangles -= 1
                    }

                } label: {
                    Text("+1")
                }
                .zIndex(20)
//                Button {
//                    homeVM.currentCollectionIndex -= 1
//                    withAnimation(.default.delay(2.0)) {
//
//                        homeVM.arrayOfNumbers.removeLast()
//                    }
//                } label: {
//                    Text("-1")
//                }
//            }
        }
    }
}

struct RemakeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RemakeHomeView()
    }
}
