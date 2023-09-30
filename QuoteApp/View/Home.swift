//
//  Home.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 30/08/2023.
//

import SwiftUI
import SwiftData



struct Home: View {

    @Environment(\.modelContext) var context
    @StateObject var homeVM = HomeVM()

    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                
                //MARK: Rectangles
                ForEach(homeVM.arrayRectanglesFaked.reversed()) { rectangle in
                    
                    let rectangleIndex = homeVM.arrayRectanglesFaked.firstIndex(where: { $0.id == rectangle.id })
                    
                    Rectangle()
                        .fill(rectangle.color)
                        .frame(width: homeVM.playBridgeAnimation ? 500 : rectangleIndex == homeVM.currentRectangle ? 600 : 500,
                               height: 600)
                        .offsetRectangle(rectangelIndexInArray: rectangleIndex!, currentRectangle: homeVM.currentRectangle)
                        .rotationEffectRectangle(rectangelIndexInArray: rectangleIndex!, currentRectangle: homeVM.currentRectangle)

                        .rotationEffect(.degrees(homeVM.playBridgeAnimation ? 0 : rectangleIndex == homeVM.currentRectangle ? 83 : 0), anchor: .center)
                        .offset(x: homeVM.playBridgeAnimation ? 0 : rectangleIndex == homeVM.currentRectangle ? 216 : 0,
                                y: homeVM.playBridgeAnimation ? 0 : rectangleIndex == homeVM.currentRectangle ? -383 : 0 )
                        .zIndex(Double(homeVM.arrayRectanglesFaked.count - rectangleIndex!))
                    
                    
                }
                
                
                //MARK: Title and tools
                TitleAndTools()
                    .frame(width: proxy.size.width)
                .zIndex(1000)
                
                //MARK: Collections
                VStack {

                    ForEach(homeVM.firstThreeCollections, id: \.?.changeId) { collection in
                        CollectionFilledView(collection, currentIndex: homeVM.currentCollectionIndex)
                    }
                    
                    .animation(.default.speed(1), value: homeVM.currentCollectionIndex)
                    
                }
                .offset(x: -30, y: 125)
                .zIndex(1000)
                
                VStack {
                    ForEach(homeVM.firstFourCollections, id: \.?.changeId) { collection in
                        CollectionOutLinedView(collection, currentIndex: homeVM.currentCollectionIndex)
                    }
                    
                    .animation(.default.speed(1), value: homeVM.currentCollectionIndex)
                    
                }
                .offset(x: -30, y: 50)
                .zIndex(1000)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .overlay(content: {
                homeVM.openCollection ? CllectionView(collectionVM: CollectionVM(currentCollection: homeVM.quoteCollections[homeVM.currentCollectionIndex], modelContext: context),  collectionIsOpen: $homeVM.openCollection, playBridgeAnimation: $homeVM.playBridgeAnimation, rectangle: homeVM.arrayRectanglesFaked[homeVM.currentRectangle]) : nil
                
            })
            
            .onAppear {
                homeVM.modelContext = context
                homeVM.fetchCollections()
                homeVM.setUpFakedCollections()
                if homeVM.quoteCollections.count < 2 {
                    homeVM.currentCollectionIndex = 0
                }
                for rectangle in customRectanglesArray {
                    homeVM.arrayRectanglesFaked.append(rectangle)
                }
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

                            } else {
                                homeVM.updateData()
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
                            } else {
                                homeVM.createNewCollection()
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
    
    @ViewBuilder
    private func CollectionOutLinedView(_ collection: QuoteCollection?, currentIndex: Int) -> some View {
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
    private func CollectionFilledView(_ collection: QuoteCollection?, currentIndex: Int) -> some View {
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
                                    if homeVM.fakedQuoteCollections.nextElementAfter(homeVM.currentCollectionIndex) != nil {
                                        homeVM.currentCollectionIndex += 1
                                        homeVM.currentRectangle += 1
                                        homeVM.appentNextRectangleAfter(homeVM.arrayRectanglesFaked.last!, realCollection: customRectanglesArray)
                                    }
                                    homeVM.draggOffset = 0
                                }
                                
                                if homeVM.shouldRemoveRectangles(passed: 9) {
                                    withAnimation {
                                        homeVM.arrayRectanglesFaked.removeFirst(8)
                                        homeVM.currentRectangle = 1
                                    }
                                }
                                
                                
                                print(homeVM.arrayRectanglesFaked.count)

                            }
                            else if homeVM.draggOffset < -20 {
                                withAnimation {
                                    if homeVM.fakedQuoteCollections.elementBefore(homeVM.currentCollectionIndex) != nil {
                                        homeVM.currentCollectionIndex -= 1
                                        homeVM.arrayRectanglesFaked.removeLast()
                                        homeVM.insertNextRectangleAfter(homeVM.arrayRectanglesFaked.first!, realCollection: customRectanglesArray)
                                    }
                                    homeVM.draggOffset = 0
                                }
                                
                                print(homeVM.arrayRectanglesFaked.count)
                            }
                            else {
                                withAnimation {
                                    homeVM.draggOffset = 0
                                }
                            }
                        })
                )

            if homeVM.settingsMode {
                TextField("Name of collection", text:  $homeVM.text.max(19))
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
        .onTapGesture {
            if !homeVM.settingsMode {
                homeVM.openCollection = true
                homeVM.playBridgeAnimation = false
            }
        }
        .opacity(homeVM.collecitonIsEqualToCurrent(collection) ? 1 : 0)
        .frame(width: 240, height: 150)
    }
    

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
