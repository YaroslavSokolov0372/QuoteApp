//
//  HomeViewSketch.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 19/09/2023.
//

import SwiftUI

struct HomeViewSketch: View {
    
//    func appendInfinityCollection(lastElement: CollectionModel) {
//
//        if var lastCollection = homeVM.arrayOfNumbers.firstIndex(where: { $0.num == lastElement.num }) {
//
//            if lastCollection == homeVM.arrayOfNumbers.count - 1 {
//                lastCollection = 0
//                var nextElement = homeVM.arrayOfNumbers[lastCollection]
//                nextElement.id = .init()
//                homeVM.arrayOfNumbersFaked.append(nextElement)
//            } else {
//                lastCollection += 1
//                var nextElement = homeVM.arrayOfNumbers[lastCollection]
//                nextElement.id = .init()
//                homeVM.arrayOfNumbersFaked.append(nextElement)
//            }
//        }
//    }
//
//    func appendPreviouseElement(firstElement: CollectionModel) {
//        if var firstCollection = homeVM.arrayOfNumbers.firstIndex(where: { $0.num == firstElement.num }) {
//            if firstCollection == 0 {
//                firstCollection = homeVM.arrayOfNumbers.count - 1
//                var nextElement = homeVM.arrayOfNumbers[firstCollection]
//                nextElement.id = .init()
//                homeVM.arrayOfNumbersFaked.insert(nextElement, at: 0)
//            } else {
//                firstCollection -= 1
//                var nextElement = homeVM.arrayOfNumbers[firstCollection]
//                nextElement.id = .init()
//                homeVM.arrayOfNumbersFaked.insert(nextElement, at: 0)
//            }
//        }
//    }
//
//
//    func whichColortNext2(firstElement: CustomRectangle) -> LinearGradient {
//
//        var gradientFromStartElement = gradients1.firstIndex(where: { $0 == firstElement.color })
//
////        print(gradientFromLastElement as Any)
//        if gradientFromStartElement == 0 {
//            gradientFromStartElement = 7
//            return gradients1[gradientFromStartElement!]
//        } else {
//            return gradients1[gradientFromStartElement! - 1]
//        }
//    }
//
//    func whichColortNext(lastElement: CustomRectangle) -> LinearGradient {
//
//        var gradientFromLastElement = gradients1.firstIndex(where: { $0 == lastElement.color })
//
////        print(gradientFromLastElement as Any)
//        if gradientFromLastElement == gradients1.count - 1 {
//            gradientFromLastElement = 0
//            return gradients1[gradientFromLastElement!]
//        } else {
//            return gradients1[gradientFromLastElement! + 1]
//        }
//    }
//
//    func shouldRemoveRectanglesBefore(_ rectangels: Int) -> Bool {
//        var beforeCurrentRectangleCount = 0
//        for index in arrayRectangles.indices {
//            if index < realIndex {
//                beforeCurrentRectangleCount += 1
//            }
//        }
////        print("Elements before current index -", beforeCurrentRectangleCount)
//        return beforeCurrentRectangleCount >= rectangels
//    }
//
//    func shouldRemoveCollections(_ countToDelete: Int) -> Bool {
//        var passedCollecionsCount = 0
//        for index in homeVM.arrayOfNumbersFaked.indices {
//            if index < realIndex {
//                passedCollecionsCount += 1
//            }
//        }
//        return passedCollecionsCount >= countToDelete
//    }
//
//
//
//    @State var arrayRectangles: [CustomRectangle] = []
//    @State var currentRectangle = 1
//    @State var realIndex = 1
    @StateObject var homeVM = HomeVM()

    
    
    
    var body: some View {
        ZStack {
            
            ForEach(homeVM.arrayRectangles.reversed()) { rectangle in

                 let rectangleIndex = homeVM.arrayRectangles.firstIndex(where: { $0.id == rectangle.id })
                    
                    Rectangle()
                        .fill(rectangle.color)
                        .frame(width: 500, height: 600)
                        .offsetRectangle(rectangelIndexInArray: rectangleIndex!, currentRectangle: homeVM.currentRectangle)
                        .rotationEffectRectangle(rectangelIndexInArray: rectangleIndex!, currentRectangle: homeVM.currentRectangle)
                        .zIndex(Double(homeVM.arrayRectangles.count - rectangleIndex!))
//                        .opacity(currentRectangle + 7 >= rectangleIndex! ? 1 : 0)
                
                

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
    
    @ViewBuilder
    private func NumberViewOutlined(_ collection: CollectionModel?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Text(collection != nil ? String(collection!.num) : "")
                .customFont(70, .halenoirOutline)
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
                    .customFont(collection == homeVM.arrayOfNumbersFaked[currentIndex] ? 90 : 80, .halenoir)
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
//                                        realIndex += 1
                                    }
                                    
                                    homeVM.appendNextCollectionAfter(homeVM.arrayOfNumbersFaked.last)
                                    homeVM.appentNextGradientAfter(homeVM.arrayRectangles.last!, realCollection: gradients1)
                                    
//                                  appendInfinityCollection(lastElement: homeVM.arrayOfNumbersFaked.last!)
                                    
//                                    if var lastRectangle = arrayRectangles.last {
//                                        lastRectangle.id = .init()
//                                        lastRectangle.color = whichColortNext(lastElement: lastRectangle)
//                                        arrayRectangles.append(lastRectangle)
//                                    }
                                    
                                    if homeVM.shouldRemoveRectangles(passed: 9) {
                                        withAnimation {
                                            homeVM.arrayRectangles.removeFirst(8)
                                            homeVM.currentRectangle = 1
//                                            realIndex = 1
                                        }
                                    }
                                    if homeVM.shouldRemoveCollections(passed: homeVM.arrayOfNumbers.count + 1) {
                                        withAnimation {
                                            homeVM.arrayOfNumbersFaked.removeFirst(8)
                                            homeVM.currentCollectionIndex = 1
                                        }
                                    }
                                    
//                                    if shouldRemoveCollections(homeVM.arrayOfNumbers.count + 1) {
//                                        withAnimation {
//                                            homeVM.arrayOfNumbersFaked.removeFirst(8)
//                                            homeVM.currentCollectionIndex = 1
//                                        }
//                                    }
//
//
//                                    if shouldRemoveRectanglesBefore(9) {
//                                        withAnimation {
//                                            arrayRectangles.removeFirst(8)
//                                            currentRectangle = 1
//                                            realIndex = 1
//                                        }
//                                    }
                                    
                                    print(homeVM.arrayOfNumbers.count)
                                    print(homeVM.arrayOfNumbersFaked.count)
//                                    print("real index -", realIndex)
                                    
                                } else if homeVM.draggOffset < -20 {
                                    
                                    withAnimation {
                                        homeVM.arrayRectangles.removeLast()
//                                        arrayRectangles.insert(CustomRectangle(color: whichColortNext2(firstElement: arrayRectangles.first!),
//                                                                               id: .init()), at: 0)
                                        homeVM.insertNextGradientAfter(homeVM.arrayRectangles.last!, realCollection: gradients1)
//                                        homeVM.insertNextCollectionAfter(homeVM.arrayOfNumbersFaked.first, realCollection: homeVM.arrayOfNumbers)
                                        
                                        
                                        //                                        homeVM.currentCollectionIndex -= 1
                                        homeVM.draggOffset = 0
                                        homeVM.arrayOfNumbersFaked.removeLast()
                                        homeVM.insertNextCollectionAfter(homeVM.arrayOfNumbersFaked.first, realCollection: homeVM.arrayOfNumbers)
//                                        appendPreviouseElement(firstElement: homeVM.arrayOfNumbersFaked.first!)
                                        print(homeVM.arrayOfNumbersFaked.count)
                                    }
                                    
                                    
                                }
                                else {
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
    
    //            Text(number != nil ? "quotes from friends" : "")
    //                .customFont(15, .mono)
            }
            .opacity(collection == homeVM.arrayOfNumbersFaked[currentIndex] ? 1 : 0)
            .frame(width: 200, height: homeVM.arrayOfNumbersFaked[currentIndex] == collection ? 160 : 150)
    
        }
}

struct HomeViewSketch_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSketch()
    }
}




