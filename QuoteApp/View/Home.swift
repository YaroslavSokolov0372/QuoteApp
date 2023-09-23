//
//  Home.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 30/08/2023.
//

import SwiftUI

struct Home: View {

    @StateObject var homeVM = HomeVM()

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                
                ForEach(homeVM.arrayRectangles.reversed()) { rectangle in
                    
                    let rectangleIndex = homeVM.arrayRectangles.firstIndex(where: { $0.id == rectangle.id })
                    
                    Rectangle()
                        .fill(rectangle.color)
                        .frame(width: 500, height: 600)
                        .offsetRectangle(rectangelIndexInArray: rectangleIndex!, currentRectangle: homeVM.currentRectangle)
                        .rotationEffectRectangle(rectangelIndexInArray: rectangleIndex!, currentRectangle: homeVM.currentRectangle)
                        .zIndex(Double(homeVM.arrayRectangles.count - rectangleIndex!))
                    
                }
                VStack {
                    ForEach(homeVM.sortedArrayOfNumbers, id: \.?.id) { collection in
                        NumberViewOutlined(collection, currentIndex: homeVM.currentCollectionIndex)
                    }
                    .animation(.default.speed(1), value: homeVM.currentCollectionIndex)
                }
                .offset(x: -30, y: 70)
                .zIndex(1000)
                VStack {
                    ForEach(homeVM.sortedArrayOfNumbersFilled, id: \.self) { collection in
                        NumberViewFilled(collection, currentIndex: homeVM.currentCollectionIndex)
                    }
                    .animation(.default.speed(1), value: homeVM.currentCollectionIndex)
                }
                .offset(x: -30, y: 150)
                .zIndex(1000)
                
            }
            
            .frame(width: proxy.size.width, height: proxy.size.height)
            .overlay(content: {
                homeVM.openCollection ? CllectionViewSketchToOriginal(gradient: gradients1[homeVM.currentRectangle]) : nil
            })
            
            .onAppear {
                for gradient in gradients1 {
                    homeVM.arrayRectangles.append(CustomRectangle(color: gradient, id: .init()))
                }
                //            if var firstRectangle = homeVM.arrayRectangles.first {
                //                firstRectangle.id = .init()
                //                homeVM.arrayRectangles.append(firstRectangle)
                //            }
                
                for var collection in homeVM.sortedArrayOfNumbers.reversed() {
                    if collection != nil {
                        collection!.id = .init()
                        homeVM.arrayOfNumbersFaked.append(collection!)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func NumberViewOutlined(_ collection: CollectionModel?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Text(collection != nil ? String(collection!.num) : "")
                .customFont(collection == homeVM.arrayOfNumbersFaked[currentIndex] ? 90 : 70, .halenoirOutline)
            Text(collection != nil ? "quotes from friends" : "")
                .customFont(15, .mono)
        }
        .opacity(collection == homeVM.arrayOfNumbersFaked[currentIndex] ? 0 : 1)
        .frame(width: 200 ,height: homeVM.arrayOfNumbersFaked[currentIndex] == collection ? 160 : 150)
    }
    
    private func NumberViewFilled(_ collection: CollectionModel?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Spacer()


            Text(collection != nil ? String(collection!.num) :  "")
                .customFont(collection == homeVM.arrayOfNumbersFaked[currentIndex] ? 90 : 70, .halenoir)
                .offset(y: collection == homeVM.arrayOfNumbersFaked[currentIndex] ? homeVM.draggOffset : 0)

                .gesture(
                    DragGesture(minimumDistance: 0.6)
                        .onChanged({ value in
                            homeVM.draggOffset = value.translation.height / 3.5

                        })
                        .onEnded({ value in
                            if homeVM.draggOffset > 25 {
                                
                                withAnimation {
                                    homeVM.currentCollectionIndex += 1
                                    homeVM.currentRectangle += 1
                                    homeVM.draggOffset = 0
                                }
                                
                                homeVM.appendNextCollectionAfter(homeVM.arrayOfNumbersFaked.last)
                                homeVM.appentNextGradientAfter(homeVM.arrayRectangles.last!, realCollection: gradients1)
                                
                                
                                if homeVM.shouldRemoveRectangles(passed: 9) {
                                    withAnimation {
                                        homeVM.arrayRectangles.removeFirst(8)
                                        homeVM.currentRectangle = 1
                                    }
                                }
                                if homeVM.shouldRemoveCollections(passed: homeVM.arrayOfNumbers.count + 1) {
                                    withAnimation {
                                        homeVM.arrayOfNumbersFaked.removeFirst(8)
                                        homeVM.currentCollectionIndex = 1
                                    }
                                }

                                print(homeVM.currentRectangle)
                            } else if homeVM.draggOffset < -20 {
                                
                                withAnimation {
                                    homeVM.arrayRectangles.removeLast()
                                    homeVM.insertNextGradientAfter(homeVM.arrayRectangles.last!,
                                                                    realCollection: gradients1)
                                    homeVM.draggOffset = 0
                                    homeVM.arrayOfNumbersFaked.removeLast()
                                    homeVM.insertNextCollectionAfter(homeVM.arrayOfNumbersFaked.first,
                                                                        realCollection: homeVM.arrayOfNumbers)
                                    print(homeVM.arrayOfNumbersFaked.count)
                                }
                            } else {
                                withAnimation {
                                    homeVM.draggOffset = 0
                                }
                            }
                        })
                )
                .onTapGesture {
                    print("hello world")
                    homeVM.openCollection = true
                }
                .offset(y: 50)
            TextField("name of collection", text: $homeVM.nameOffCurrentCollection)
                .customFont(15, .mono)
                .disabled(!homeVM.settingsMode)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .opacity(homeVM.settingsMode ? 1 : 0)

                )
        }
        .opacity(collection == homeVM.arrayOfNumbersFaked[currentIndex] ? 1 : 0)
        .frame(width: 200, height: homeVM.arrayOfNumbersFaked[currentIndex] == collection ? 160 : 150)

    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var homeVM = HomeVM()
        Home(homeVM: homeVM)
    }
}


