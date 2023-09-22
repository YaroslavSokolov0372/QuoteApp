//
//  RemakeHomeView.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 18/09/2023.
//

import SwiftUI

struct RemakeHomeView: View {
    
    @State var arrayRectangles: [CustomRectangle] = []
    @State var currentRectangle = 1
    @State var realIndex = 1 {
        willSet {
//            newValue > maxIndex ? maxIndex = newValue : nil
        }
    }
    
    
    @State var maxIndex = 1
    @State var minIndex = 1
    
    func whichColortNext(lastElement: CustomRectangle) -> LinearGradient {

        var gradientFromLastElement = gradients1.firstIndex(where: { $0 == lastElement.color })

//        print(gradientFromLastElement as Any)
        if gradientFromLastElement == gradients1.count - 1 {
            gradientFromLastElement = 0
            return gradients1[gradientFromLastElement!]
        } else {
            return gradients1[gradientFromLastElement! + 1]
        }
        
    }
    
    func whichColortNext2(firstElement: CustomRectangle) -> LinearGradient {

        var gradientFromStartElement = gradients1.firstIndex(where: { $0 == firstElement.color })

//        print(gradientFromLastElement as Any)
        if gradientFromStartElement == 0 {
            gradientFromStartElement = 7
            return gradients1[gradientFromStartElement!]
        } else {
            return gradients1[gradientFromStartElement! - 1]
        }
        
    }

    
    func isCurrentIndexMax(_ currentIndex: Int, maxIndex : inout Int) -> Bool {
        if currentIndex > maxIndex {
            maxIndex = currentIndex
            return true
        } else {
            return false
        }
    }
    
    func isCurrentMinIndex(_ currentIndex: Int, minIndex : inout Int) -> Bool {
        if currentIndex < minIndex {
            minIndex = currentIndex
            return true
        } else {
            return false
        }
    }
    
    
//    {
//        willSet {
//            if newValue > currentRectangle {
//                 currentRectangle = newValue
//            } else {
////                currentRectangle = currentRectangle
//            }
//        }
//    }
//    var rightCountForCurrentRectangle: Int {
//        get {
//            currentRectangle
//        }
//        set {
//            if newValue < currentRectangle {
//
//            }
//        }
//    }
    
    
    func offsetXRectangle(index: Int, currentRectangle: Int) -> CGFloat {
        let difference = index - currentRectangle
        let multiply = CGFloat(difference) * 55
        if difference < 0 {
            return -500
        }
        
        return multiply + 55
    }
    
    func offsetYRectangle(index: Int, currentRectangle: Int) -> CGFloat {
        let difference = index - currentRectangle
        let multiply = CGFloat(difference) * -20
        if difference < 0 {
            return 250
        }
        
        return -85 + multiply
    }
    
    func rotationEffectRectangle(index: Int, currentRectangle: Int) -> Double {
        let difference = index - currentRectangle
        let multiply = Double(difference) * 6
        if difference < 0 {
            return -60
        }
        return -33 + Double(multiply)
    }
    
    func shouldRemoveRectanglesBefore(_ rectangels: Int) -> Bool {
        var beforeCurrentRectangleCount = 0
        for index in arrayRectangles.indices {
            if index < realIndex {
                beforeCurrentRectangleCount += 1
            }
        }
//        print("Elements before current index -", beforeCurrentRectangleCount)
        return beforeCurrentRectangleCount >= rectangels
    }
    
    func shouldRemoveRectanglesAfter(_ rectangels: Int) -> Bool {
        var afterCurrentRectangleCount = 0
        for index in arrayRectangles.indices {
            if index > realIndex {
                afterCurrentRectangleCount += 1
            }
        }
//        print("Elements before current index -", afterCurrentRectangleCount)
        return afterCurrentRectangleCount == rectangels

    }

    
    var body: some View {
        ZStack {
            ForEach(arrayRectangles) { rectangle in

                let rectangleIndex = arrayRectangles.firstIndex(where: { $0.id == rectangle.id })


                Rectangle()
                    .fill(rectangle.color)
                    .frame(width: 600, height: 600)
                    .offset(
                        x: offsetXRectangle(index: rectangleIndex!, currentRectangle: currentRectangle),
//                                                    x: 55 + (CGFloat(rectangleIndex! - currentRectangle) * 55),
//                                                    y: -85 + (CGFloat(rectangleIndex! - currentRectangle) * -20))
                        y: offsetYRectangle(index: rectangleIndex!, currentRectangle: currentRectangle))
                    .rotationEffect(.degrees(rectangleIndex! < currentRectangle ? -60 : -33 + (Double(rectangleIndex! - currentRectangle) * 6)),
                                    anchor: .topTrailing)
//                    .rotationEffect(.degrees(rotationEffectRectangle(index: rectangleIndex!, currentRectangle: currentRectangle)))
                    .zIndex(Double(arrayRectangles.count - rectangleIndex!))

            }
            VStack(spacing: 30){
                Button {
                    
                    withAnimation {
                        currentRectangle += 1
                        realIndex += 1
                    }
                    
//                    if isCurrentIndexMax(realIndex, maxIndex: &maxIndex) {
//                        if var passedRectangle = arrayRectangles.elementBefore(currentRectangle) {
//                            passedRectangle.id = .init()
//                            arrayRectangles.append(passedRectangle)
//                        }
//                    }
                    
//                    if isCurrentIndexMax(realIndex, maxIndex: &maxIndex) {
                        if var lastRectangle = arrayRectangles.last {
                            lastRectangle.id = .init()
                            lastRectangle.color = whichColortNext(lastElement: lastRectangle)
                            arrayRectangles.append(lastRectangle)
                        }
                        if shouldRemoveRectanglesBefore(9) {
                            withAnimation {
                                arrayRectangles.removeFirst(8)
                                currentRectangle = 1
                                realIndex = 1
                                maxIndex = 1
//                                count = 1
//                                minIndex = 1
//                            }
                        }
                    }
                    print("MaxIndex - ",maxIndex)
                    print("Count of rectangles ",arrayRectangles.count)
                    print("RealIndex ",realIndex)
                    print("current rectangle - \(currentRectangle)")
                } label: {
                    Text("currentRectangle += 1")
                }
                
                Button {
                    
                    withAnimation {
                        arrayRectangles.removeLast()
                        arrayRectangles.insert(CustomRectangle(color: whichColortNext2(firstElement: arrayRectangles.first!), id: .init()), at: 0)

                    }
                    print("MaxIndex - ",maxIndex)
                    print("Count of rectangles ",arrayRectangles.count)
                    print("RealIndex ",realIndex)
                    print("current rectangle - \(currentRectangle)")
                    
//                    print("currentRectangle - \(currentRectangle)")
                    //                    print("count - \(count)")
                    //                    if isCurrentMinIndex(currentRectangle, minIndex: &minIndex) {
                        
                    //MARK: - First variant
//                    var beforeLast = arrayRectangles.elementBefore(arrayRectangles.count - 1)
//                    arrayRectangles.removeAll(where: { $0.id == beforeLast?.id })
//                    beforeLast?.id = .init()
//                    arrayRectangles.insert(beforeLast!, at: 0)
                    //MARK: - SecondVariant

                    
//                    if var lastRectangle = arrayRectangles.last {
//
//                        lastRectangle.id = .init()
//                        if let lastGradient = gradients1.last {
//                            lastRectangle.color = lastGradient
//                            gradients1.removeLast()
//                            gradients1.insert(lastGradient, at: 0)
//
//                        }
//                        withAnimation {
////                            if isCurrentMinIndex(count, minIndex: &minIndex) {
//                                arrayRectangles.removeLast()
////                            }
//                            arrayRectangles.insert(lastRectangle, at: 0)
//
//                        }
//                    }
                    //                    }
//                    print("Count of rectangles ",arrayRectangles.count)
//                    print("current rectangle - \(currentRectangle)")
//                    print("RealIndex ",realIndex)
                    
                                        
//                                        if shouldRemoveRectanglesAfter(8) {
////                                            arrayRectangles.removeLast(8)
//                                            currentRectangle = 1
//                                            realIndex = 1
//                                            minIndex = 1
//                                            maxIndex = 1
//                                        }
//                                        print(arrayRectangles.count)
                } label: {
                    Text("currentRectangle -= 1")
                }
            }
            .zIndex(100)

        }
        .onAppear {
            for gradient in gradients1 {
                arrayRectangles.append(CustomRectangle(color: gradient, id: .init()))
            }
            
            if var firstRectangle = arrayRectangles.first {
                firstRectangle.id = .init()
                arrayRectangles.append(firstRectangle)

            }
//            print(arrayRectangles.count)
//            print(arrayRectangles.count)

        }
    }
}

struct RemakeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RemakeHomeView()
    }
}
