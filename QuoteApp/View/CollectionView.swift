//
//  CollectionView.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 16/09/2023.
//

import SwiftUI

struct CollectionView: View {
    
    
    @StateObject var collectionVM =  CollectionVM()
    
    let arrayOfNumbers: [Int] = [07, 12, 32, 14, 42, 02, 01]

    var currentIndex = 0
    
    var sortedArrayOfNumbers2: [Int?] {
        return [
            arrayOfNumbers.nextElementAfter(currentIndex + 1) ?? nil,
                arrayOfNumbers.nextElementAfter(currentIndex) ?? nil,
                arrayOfNumbers[currentIndex],
                arrayOfNumbers.elementBefore(currentIndex) ?? nil
        ]
    }
    
    @State var delayedOpacityRectangle: Bool = false

    @State var playAnimation = false
    
    
    var gri = LinearGradient(colors: [Color("Color7"), Color("Color8")], startPoint: .topLeading, endPoint: .bottomTrailing)
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                ForEach(sortedArrayOfNumbers2.indices.reversed(), id: \.self) { index in
                    Rectangle()
                        .fill(gri)
                        .frame(width: 600, height: 600)
                        .offset(x: 50 , y: -45)
                        .rotationEffect(.degrees(-33), anchor: .topTrailing)
                        .rotationEffect(.degrees(collectionVM.playAnimation ? 83 : 0), anchor: .center)
                        .offset(x: collectionVM.playAnimation ? 150 : 0,
                                y: collectionVM.playAnimation ? -400 : 0)
                        .rotationEffect(.degrees(Double(5 * index)), anchor: .center)
                        .opacity(1 - 0.25 * Double(index))
                        .opacity(index == 0 ? 1 : delayedOpacityRectangle ? 1 : 0)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.spring(dampingFraction: 1.0, blendDuration: 0.0)){
                        collectionVM.playAnimation.toggle()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring(dampingFraction: 1.0, blendDuration: 0.0).speed(0.4)) {
                        collectionVM.playDelayedOpacityAnimation = true
//                        playQuoteAnimation = true
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
//                        shouldCloseQuoteView = false
                        //                        withAnimation(.default.speed(1.2)){
                        ////                            playAnimation.toggle()
                        //                        }
                    } label: {
                        Image("arrowImage")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .rotationEffect(.degrees(180))
                        
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.default.speed(1.2)){
//                            settingsMode.toggle()
////                                change = true
//                            moreInfo = true
                        }
                    } label: {
                        Image("moreImage")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }

                }
            }
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
