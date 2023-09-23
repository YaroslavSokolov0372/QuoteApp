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
        Text("fda")
        
    }
}

struct HomeViewSketch_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSketch()
    }
}




