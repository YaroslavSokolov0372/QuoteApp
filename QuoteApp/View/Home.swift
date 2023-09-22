////
////  Home.swift
////  QuoteApp
////
////  Created by Yaroslav Sokolov on 30/08/2023.
////
//
//import SwiftUI
//
//struct Home: View {
//    
////    @StateObject var homeVM = HomeVM()
//    @StateObject var homeVM = HomeVM()
//    
//    
////    var intRandom = Int.random(in: 0...6)
////    var colors: [Color] = [.indigo, .brown, .orange, .red, .green, .gray, .blue]
//
//    var body: some View {
//
//            ZStack {
//                //MARK: -Rectangles
//                ForEach(homeVM.arrayOfNumbers.indices.reversed(), id: \.self) { num in
//                        Rectangle()
////                            .fill(colors[num])
//                        .fill(gradients[num])
////                        .fill(gri)
//                            .frame(width: 500, height: 600)
//                            .offsetRectangle(currentIndex: homeVM.currentCollectionIndex, num: num)
////                            .offset(x: offsetXRectangle(num: num, currentIndex: homeVM.currentCollectionIndex), y: offsetYRectangle(num: num, currentIndex: homeVM.currentCollectionIndex))
//                            .rotationEffect(.degrees(num < homeVM.currentCollectionIndex ? -90 : rotationDegrees(num: num, currentIndex: homeVM.currentCollectionIndex)), anchor: .topTrailing)
////                            .offsetRectangle(currentIndex: homeVM.currentCollectionIndex, num: num)
//                            .animation(.easeIn(duration: 0.33), value: homeVM.currentCollectionIndex)
//                }
//
//                //MARK: -QuotesCollections
//                
//                    VStack {
//                        ForEach(homeVM.sortedArrayOfNumbers, id: \.self) { num in
//                            NumberViewOutlined(num, currentIndex: homeVM.currentCollectionIndex)
//                        }
//                        .animation(.default.speed(1), value: homeVM.currentCollectionIndex)
//
//                    }
//                    .offset(x: -30, y: 70)
//                    VStack {
//                        ForEach(homeVM.sortedArrayOfNumbersFilled, id: \.self) { num in
//                            NumberViewFilled(num, currentIndex: homeVM.currentCollectionIndex)
//                        }
//                        .animation(.default.speed(1), value: homeVM.currentCollectionIndex)
//                    }
//                    .offset(x: -30, y: 150)
//                
//                
//                
//                //MARK: -Title and MenuBar
//                HStack {
//                    VStack {
//                        Text("My Quotes")
//                            .customFont(37, .mono)
//                            .padding(.leading, 50)
//                        
//                        Spacer()
//                            .frame(height: 670)
//                    }
//                    .frame(width: 300)
//                    
//                    VStack {
//                        Button {
//                            homeVM.settingsMode.toggle()
//                        } label: {
//                            Image("moreImage")
//                                .resizable()
//                                .frame(width: 30, height: 25)
//                        }
//                        .padding(.leading)
//                        
//                        
//                        Spacer()
//                        
//                        Button {
//                            withAnimation {
//                                homeVM.arrayOfNumbers.insert(0, at: 0)
//                                homeVM.settingsMode = true
//                            }
//                            
//                        } label: {
//                            Image(homeVM.settingsMode ? "trashImage" : "plusImage")
//                                .resizable()
//                                .frame(width: homeVM.settingsMode ? 60 : 80, height: homeVM.settingsMode ? 60 : 80)
//                        }
//                        .padding(.trailing)
//                        Spacer()
//                            .frame(height: 170)
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                
//            }
//            .opacity(homeVM.openCollection ? 0 : 1)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .overlay {
//                if homeVM.openCollection {
//                    Test(shouldCloseQuoteView: $homeVM.openCollection)
//                }
//            }
//        }
//    
//    
//    @ViewBuilder
//    private func NumberViewOutlined(_ number: Int?, currentIndex: Int) -> some View {
//        VStack(alignment: .leading) {
//            Text(number != nil ? String(number!) : "")
//                .customFont(70, .halenoirOutline)
//            Text(number != nil ? "quotes from friends" : "")
//                .customFont(15, .mono)
//        }
//        .opacity(number == homeVM.arrayOfNumbers[currentIndex] ? 0 : 1)
//        .frame(width: 200 ,height: homeVM.arrayOfNumbers[currentIndex] == number ? 160 : 150)
//    }
//    
//    private func NumberViewFilled(_ number: Int?, currentIndex: Int) -> some View {
//        VStack(alignment: .leading) {
//            Spacer()
//            
//            
//            Text(number != nil ? String(number!) :  "")
//                .customFont(number == homeVM.arrayOfNumbers[currentIndex] ? 90 : 70, .halenoir)
//                .offset(y: number == homeVM.arrayOfNumbers[currentIndex] ? homeVM.draggOffset : 0)
//                
//                .gesture(
//                    DragGesture(minimumDistance: 0.6)
//                        .onChanged({ value in
//                            homeVM.draggOffset = value.translation.height / 3.5
//                            //                                    playAnimation = false
//                            //                                    print(draggOffset)
//                        })
//                        .onEnded({ value in
//                            if homeVM.draggOffset > 26 {
////                                withAnimation(.easeOut(duration: 0.35)){
//                                homeVM.draggOffset = 0
//                                homeVM.currentCollectionIndex += 1
//                                    //                                    print(currentIndex)
////                                }
//                            } else if homeVM.draggOffset < -20 {
////                                withAnimation(.easeOut(duration: 0.2)){
//                                homeVM.draggOffset = 0
//                                homeVM.currentCollectionIndex -= 1
//                                    //                                    print(currentIndex)
////                                }
//                            }
//                            else {
//                                withAnimation {
//                                    homeVM.draggOffset = 0
//                                }
//                            }
//                        })
//                )
//                .onTapGesture {
//                    print("hello world")
//                    homeVM.openCollection = true
//                }
//                .offset(y: 50)
//            TextField("name of collection", text: $homeVM.nameOffCurrentCollection)
//                .customFont(15, .mono)
//                .disabled(!homeVM.settingsMode)
//                .padding(8)
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(lineWidth: 1)
//                        .opacity(homeVM.settingsMode ? 1 : 0)
//                        
//                )
//                
////            Text(number != nil ? "quotes from friends" : "")
////                .customFont(15, .mono)
//        }
//        .opacity(number == homeVM.arrayOfNumbers[currentIndex] ? 1 : 0)
//        .frame(width: 200, height: homeVM.arrayOfNumbers[currentIndex] == number ? 160 : 150)
//        
//    }
//    
//}
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        @StateObject var homeVM = HomeVM()
//        Home(homeVM: homeVM)
//    }
//}
//
//
