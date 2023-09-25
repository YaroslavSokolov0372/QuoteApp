//
//  Home.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 30/08/2023.
//

import SwiftUI


struct Home: View {

    @Environment(\.modelContext) var context
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
                
                
                TitleAndTools()
                    .frame(width: proxy.size.width)
                .zIndex(1000)
                
                
                VStack {
//                    ForEach(homeVM.sortedArrayOfCollection, id: \.self) { collection in
//                        NumberViewOutlined(collection, currentIndex: homeVM.currentCollectionIndex)
//                    }
//                    .animation(.default.speed(1), value: homeVM.currentCollectionIndex)
                    
                    
                    ForEach(homeVM.sortedArrayOfCollectionFilled, id: \.self) { collection in
                        CollectionFilledView(collection, currentIndex: homeVM.currentCollectionIndex)
                    }
                }
                .offset(x: -30, y: 125)
                .zIndex(1000)
                
                VStack {
                    ForEach(homeVM.sortedArrayOfCollection, id: \.self) { collection in
                        CollectionOutLinedView(collection, currentIndex: homeVM.currentCollectionIndex)
                    }
                }
                .offset(x: -30, y: 50)
                .zIndex(1000)
                
//                VStack {
//                    ForEach(homeVM.sortedArrayOfCollectionFilled, id: \.self) { collection in
//                        NumberViewFilled(collection, currentIndex: homeVM.currentCollectionIndex)
//                    }
//                    .animation(.default.speed(1), value: homeVM.currentCollectionIndex)
//                }
//                .offset(x: -30, y: 150)
//                .zIndex(1000)
            }
            
            .frame(width: proxy.size.width, height: proxy.size.height)
            .overlay(content: {
                homeVM.openCollection ? CllectionViewSketchToOriginal(gradient: gradients1[homeVM.currentRectangle]) : nil
            })
            
            .onAppear {
                homeVM.modelContext = context
                homeVM.fetchCollections()
                homeVM.setUpFakedCollections()
//                if homeVM.quoteCollections.count < 1 {
//                    homeVM.currentCollectionIndex = 0
//                }
                
//                homeVM.fakedQuoteCollections = homeVM.quoteCollections
//                
//                if homeVM.quoteCollections.count > 4 {
//                    for collection in homeVM.sortedArrayOfCollection.reversed() {
//                        if collection != nil {
//                            //                        collection?.changeId = .init()
//                            homeVM.fakedQuoteCollections.append(collection!)
//                        }
//                    }
//                }
                
                for gradient in gradients1 {
                    homeVM.arrayRectangles.append(gradient)
                }
                print(homeVM.currentCollectionIndex)
                
            }
        }
    }
    
    @ViewBuilder
    private func TitleAndTools() -> some View {
        GeometryReader { proxy in
            HStack {
                Spacer()
                
                VStack {
                    Text("My Quotes")
                        .customFont(37, .mono)
                    
                    Spacer()
                }
                .padding(.top, 20)
                .frame(width: proxy.size.width / 1.6)
                
                VStack(alignment: .trailing) {
                    Button {
                        withAnimation {
                            homeVM.settingsMode.toggle()
                            if homeVM.settingsMode {
                                homeVM.prepareForSettingsMode()
//                                if homeVM.isCurrentIndexExist() {
//                                    homeVM.text = homeVM.quoteCollections[homeVM.currentCollectionIndex].name
//                                }
                            } else {
                                homeVM.updateData()
//                                homeVM.updateData()
//                                homeVM.text = homeVM.quoteCollections[homeVM.currentCollectionIndex].name
//                                homeVM.text = ""
                            }
                        }
                    } label: {
                        Image("moreImage")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation() {
                            if homeVM.settingsMode {
                                homeVM.deleteCollection()
//                                homeVM.currentCollectionIndex -= 1
//                                homeVM.text = homeVM.quoteCollections[homeVM.currentCollectionIndex].name
//                                homeVM.setUpFakedCollections()
//                                homeVM.deleteCollection()
                            } else {
                                homeVM.createNewCollection()
//                                homeVM.createNewCollection()
//                                homeVM.setUpFakedCollections()
//                                homeVM.currentCollectionIndex = homeVM.fakedQuoteCollections.count - 1
//                                homeVM.settingsMode = true
                                
                                //                                homeVM.settingsMode = true
                                
//                                print(homeVM.quoteCollections.count)
                            }
                        }
                        
                    } label: {
                        Image("plusImageNew")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(20)
                            .background(
                                Capsule()
                                    
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.black)
                            )
                            
                    }
                    .rotationEffect(.degrees(homeVM.settingsMode ? 45 : 0))
                    
                    Spacer()
                        .frame(height: 185)
                }
                .padding(.trailing, 20)
                .frame(width:  proxy.size.width / 4, alignment: .trailing)
                    
            }
            .frame(width: proxy.size.width)
        }
    }
    
    @ViewBuilder private func CollectionOutLinedView(_ collection: CollectionsOfQuote?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Text(collection != nil ? String(collection!.quotes.count) : "")
                .customFont(homeVM.collecitonIsEqualToCurrent(collection) ? 110 : 80, .halenoirOutline)
                .padding(.leading, homeVM.collecitonIsEqualToCurrent(collection) ? 10 : 20)
                .offset(y:  homeVM.collecitonIsEqualToCurrent(collection) ? 80 : 60)
            Text(collection != nil ? collection!.name : "")
                .customFont(17, .mono)
                .padding()
                .frame(width: 240, height: 40, alignment: .leading)
        }
        .opacity(homeVM.collecitonIsEqualToCurrent(collection) ? 0 : 1)
        .frame(width: 240, height: 150)
        
        
    }
    
    @ViewBuilder
    private func CollectionFilledView(_ collection: CollectionsOfQuote?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Text(collection != nil ? String(collection!.quotes.count) : "")
                .customFont(homeVM.collecitonIsEqualToCurrent(collection) ? 110 : 80, .halenoir)
                .padding(.leading, homeVM.collecitonIsEqualToCurrent(collection) ? 10 : 20)
                .offset(y:  homeVM.collecitonIsEqualToCurrent(collection) ? 80 : 60)
                .offset(y: homeVM.collecitonIsEqualToCurrent(collection) ? homeVM.draggOffset : 0)
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
                                
//                                if homeVM.quoteCollections.count > 4 {
//                                    homeVM.predictNextItemAppend(lastItem: homeVM.fakedQuoteCollections.last,
//                                                                 realCollection: homeVM.quoteCollections,
//                                                                 &homeVM.fakedQuoteCollections)
//                                }
//                                
//                                homeVM.predictNextItemAppend(lastItem: homeVM.arrayRectangles.last, realCollection: gradients1, &homeVM.arrayRectangles)
                                
//                                homeVM.appendNextCollectionAfter(homeVM.arrayOfNumbersFaked.last)
//                                homeVM.appentNextGradientAfter(homeVM.arrayRectangles.last!, realCollection: gradients1)
                                
                                
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
                                
//                                print(homeVM.currentRectangle)
                            } 
//                            else if homeVM.draggOffset < -20 {
//                                
//                                withAnimation {
//                                    homeVM.arrayRectangles.removeLast()
////                                    homeVM.insertNextGradientAfter(homeVM.arrayRectangles.last!,
////                                                                   realCollection: gradients1)
//                                    homeVM.draggOffset = 0
//                                    homeVM.arrayOfNumbersFaked.removeLast()
//                                    homeVM.insertNextCollectionAfter(homeVM.arrayOfNumbersFaked.first,
//                                                                     realCollection: homeVM.arrayOfNumbers)
//                                    print(homeVM.arrayOfNumbersFaked.count)
//                                }
//                            }
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
            if homeVM.settingsMode {
                TextField("Name of collection", text:  $homeVM.text)
                    .customFont(17, .mono)
                    .padding()
                    .frame(width: 240, height: 40, alignment: .leading)
                
                    .background(
                        
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                        
                    )
            } else {
                Text(collection != nil ? collection!.name :  "")
                    .customFont(17, .mono)
                    .padding()
                    .frame(width: 240, height: 40, alignment: .leading)
                
            }
        }
        .opacity(homeVM.collecitonIsEqualToCurrent(collection) ? 1 : 0)
        .frame(width: 240, height: 150)
//        .opacity(homeVM.fakedQuoteCollections.isEmpty ? 0 : 1)
    }
    
    
    
    
    
    
    
    
    @ViewBuilder
    private func NumberViewOutlined(_ collection: CollectionsOfQuote?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Text(collection != nil ? String(collection!.quotes.count) : "0")
//                .customFont(homeVM.fakedQuoteCollections.elementByIndex(homeVM.currentCollectionIndex) != nil ? 90 : 70, .halenoirOutline)
                .customFont(homeVM.collecitonIsEqualToCurrent(collection) ? 90 : 70, .halenoirOutline)
            Text(collection != nil ? collection!.name : "Quotes for friends")
                .customFont(15, .mono)
        }
//        .opacity(homeVM.fakedQuoteCollections.elementByIndex(homeVM.currentCollectionIndex) != nil ? 0 : 1)
        .opacity(homeVM.collecitonIsEqualToCurrent(collection) ? 0 : 1)
        .frame(width: 200 ,height: homeVM.fakedQuoteCollections.elementByIndex(homeVM.currentCollectionIndex) != nil ? 160 : 150)
    }
    
    private func NumberViewFilled(_ collection: CollectionsOfQuote?, currentIndex: Int) -> some View {
        VStack(alignment: .leading) {
            Spacer()

            Text(collection != nil ? String(collection!.quotes.count) : "0")
//                .customFont(homeVM.fakedQuoteCollections.elementByIndex(homeVM.currentCollectionIndex) != nil ? 90 : 70, .halenoir)
//                .offset(y: homeVM.fakedQuoteCollections.elementByIndex(homeVM.currentCollectionIndex) != nil ? homeVM.draggOffset : 0)
                .customFont(homeVM.collecitonIsEqualToCurrent(collection) ? 90 : 70, .halenoir)
                .offset(y: homeVM.collecitonIsEqualToCurrent(collection) ? homeVM.draggOffset : 0)

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
//                                homeVM.appentNextGradientAfter(homeVM.arrayRectangles.last!, realCollection: gradients1)
                                
                                
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
//                                    homeVM.insertNextGradientAfter(homeVM.arrayRectangles.last!,
//                                                                    realCollection: gradients1)
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
        .opacity(homeVM.collecitonIsEqualToCurrent(collection) ? 1 : 0)
        .frame(width: 200, height: homeVM.fakedQuoteCollections.elementByIndex(homeVM.currentCollectionIndex) != nil ? 160 : 150)

    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        
//        @Environment(\.modelContext) var context
//        @StateObject var homeVM = HomeVM()
        
        
        Home()
//            .onAppear(perform: {
//                homeVM.fetchCollections()
//            })
    }
}

//#Preview {
//    Home()
//}
