//
//  CllectionViewSketchToOriginal.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 18/09/2023.
//

import SwiftUI
import Combine

struct CllectionView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.openURL) private var openURL
    @ObservedObject var collectionVM: CollectionVM
    
    @Binding var collectionIsOpen: Bool
    @Binding var playBridgeAnimation: Bool

    var rectangle: CustomRectangle
    
    var body: some View {
            ZStack {
                
                //MARK: - Top toolBar
                topToolBar()
                    .zIndex(1000)
                
                //MARK: Rectangle
                rectangles()
                
                
                VStack(spacing: 30) {
                    
                    //MARK: Quote and whom quoute
                    VStack(alignment: .leading) {
                        
                        Text("''")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .offset(y: 50)
                        
                        VStack(spacing: 0){
                            
                            ForEach(collectionVM.quotes.indices.reversed(), id: \.self) { index in
                                
                                if !collectionVM.settingsMode {
                                    Text(collectionVM.currentIndexExist() ? collectionVM.quotes[index].quote :
                                            "dsa")
                                    .customFont(27, .mono)
                                    .frame(width: 300, height: 280, alignment: .topLeading)
                                    .padding()
                                    .offset(y: collectionVM.draggOffset)
                                    .overlay {
                                        Color.white.opacity(0.01)
                                            .gesture(DragGesture().onChanged({ value in
                                                withAnimation {
                                                    collectionVM.draggOffset = value.translation.height / 3
                                                }
                                            }).onEnded({ _ in
                                                if collectionVM.draggOffset > 30 {
                                                    withAnimation {
                                                        if collectionVM.currentCollection.quotes
                                                            .nextElementAfter(collectionVM.currentIndex) != nil {
                                                            
                                                            collectionVM.currentIndex += 1
                                                            
                                                            collectionVM.prepareForSettingsMode()
                                                            
                                                        }
                                                        collectionVM.draggOffset = 0
                                                        print(collectionVM.currentIndex)
                                                    }
                                                } else if collectionVM.draggOffset < -30 {
                                                    
                                                    withAnimation {
                                                        if collectionVM.currentCollection.quotes
                                                            .elementBefore(collectionVM.currentIndex) != nil {
                                                            
                                                            collectionVM.currentIndex -= 1
                                                            
                                                            collectionVM.prepareForSettingsMode()
                                                        }
                                                        collectionVM.draggOffset = 0
                                                        print(collectionVM.currentIndex)
                                                    }
                                                } else {
                                                    withAnimation {
                                                        collectionVM.draggOffset = 0
                                                    }
                                                }
                                            }))
                                    }
                                    .offset(y: collectionVM.currentQuoteOffset())
                                    .animation(.default.speed(1.4), value: collectionVM.currentIndex)
                                    .opacity(collectionVM.currentIndex == index ? 1 : 0)
                                    .animation(.easeOut(duration: 0.1), value: collectionVM.currentIndex)
                                    
                                    
                                    
                                } else {
                                    TextField("Quote", text: $collectionVM.quote.max(144), axis: .vertical)
                                    
                                        .customFont(27, .mono)
                                        .frame(width: 300, height: 280, alignment: .topLeading)
                                        .padding()
                                        .offset(y: collectionVM.draggOffset)
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(lineWidth: 1)
                                                .opacity(collectionVM.settingsMode ? 1 : 0)
                                        )
                                        .offset(y: collectionVM.currentQuoteOffset())
                                        .opacity(collectionVM.currentIndex == index ? 1 : 0)
                                }
                            }
                            .frame(width: 300, height: 280, alignment: .topLeading)
                            
                        }
                        .frame(width: 300, height: 280)
                        .padding(.bottom, 35)
                        
                        TextField("Whom quote?", text: $collectionVM.whomQuote.max(34))
                        
                            .disabled(!collectionVM.settingsMode)
                            .textInputAutocapitalization(.characters)
                            .foregroundColor(.black.opacity(0.5))
                            .customFont(14, .mono)
                            .frame(width: 300)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                                    .opacity(collectionVM.settingsMode ? 1 : 0)
                            )
                        
                    }
                    .frame(width: 300)
                    .offset(y: collectionVM.playQuoteAnimation ? 0 : -10)
                    .opacity(collectionVM.playQuoteAnimation ? 1 : 0)
                    
                    //MARK: Info
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Button {
                            withAnimation {
                                collectionVM.moreInfo.toggle()
                            }
                        } label: {
                            HStack {
                                Text("INFO")
                                    .customFont(15, .mono)
                                    .foregroundColor(.white)
                                Image("arrowImage")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .frame(width: 17, height: 17)
                                    .rotationEffect(.degrees(90))
                            }
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.black)
                            )
                            
                        }
                        .padding(.horizontal)
                        .offset(y: collectionVM.moreInfo ? 0 : 150)
                        
                        Text("Date")
                            .foregroundColor(.gray.opacity(0.4))
                            .padding(.bottom, 1)
                            .padding(.horizontal)
                            .opacity(collectionVM.moreInfo ? 1 : 0)
                            .animation(.easeInOut(duration: collectionVM.moreInfo ? 0.8 : 0.2), value: collectionVM.moreInfo)
                        
                        HStack(spacing: 30) {
                            Text(collectionVM.currentIndexExist() ? collectionVM.quotes[collectionVM.currentIndex].formattedDate : "")
                        }
                        .customFont(13, .mono)
                        .padding(.horizontal)
                        .opacity(collectionVM.moreInfo ? 1 : 0)
                        .animation(.easeInOut(duration: collectionVM.moreInfo ? 0.8 : 0.2), value: collectionVM.moreInfo)
                        
                        
                        Text("Resource")
                            .foregroundColor(.gray.opacity(0.4))
                            .padding(.horizontal)
                            .opacity(collectionVM.moreInfo ? 1 : 0)
                            .animation(.easeInOut(duration: collectionVM.moreInfo ? 0.7 : 0.2), value: collectionVM.moreInfo)
                        
                        TextField("Link..", text: $collectionVM.link)
                            .disabled(!collectionVM.settingsMode)
                            .customFont(13, .mono)
                            .underline()
                            .frame(width: 300)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(lineWidth: 1)
                                    .opacity(collectionVM.settingsMode ? 1 : 0)
                            )
                            .overlay {
                                if !collectionVM.settingsMode {
                                    Color.white.opacity(0.01)
                                        .onTapGesture {
                                            if let url = URL(string: collectionVM.link) {
                                                openURL(url)
                                            }
                                            
                                        }
                                }
                            }
                            .opacity(collectionVM.moreInfo ? 1 : 0)
                            .animation(.easeInOut(duration: collectionVM.moreInfo ? 0.6 : 0.2), value: collectionVM.moreInfo)
                        
                        
                        
                        HStack(spacing: 50) {
                            
                            ZStack {
                                Button {
                                    collectionVM.deleteQuote()
                                } label: {
                                    Image("checkmarkImage")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                }
                                .offset(x: collectionVM.wantToDelete ? 0 : -50)
                                .opacity(collectionVM.wantToDelete ? 1 : 0)
                                .animation(.spring(.smooth, blendDuration: 0.4), value: collectionVM.wantToDelete)
                                
                                ShareLink(item: "dsadsadas") {
                                    Image("shareImage")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                }
                                .offset(y: collectionVM.wantToDelete ? 40 : 0)
                                .opacity(collectionVM.wantToDelete ? 0 : 1)
                                .animation(.spring(.smooth, blendDuration: 0.4), value: collectionVM.wantToDelete)
                            }
                            ZStack {
                                
                                Button {
                                    collectionVM.wantToDelete = false
                                } label: {
                                    Image("crossImage")
                                        .resizable()
                                        .frame(width: 40, height: 45)
                                }
                                .offset(x: collectionVM.wantToDelete ? 0 : -50)
                                .opacity(collectionVM.wantToDelete ? 1 : 0)
                                .animation(.spring(.smooth, blendDuration: 0.4), value: collectionVM.wantToDelete)
                                
                                Button {
                                    collectionVM.wantToDelete = true
                                } label: {
                                    
                                    Image( "trashImage")
                                        .resizable()
                                        .frame(width: 35, height:  35)
                                }
                                .offset(y: collectionVM.wantToDelete ? 40 : 0)
                                .opacity(collectionVM.wantToDelete ? 0 : 1)
                                .animation(.spring(.smooth, blendDuration: 0.4), value: collectionVM.wantToDelete)
                            }
                            
                            Text(collectionVM.quotes.count == 0 ? "0/0" : "\(collectionVM.currentIndex + 1)/\(collectionVM.currentCollection.quotes.count)")
                                .customFont(18, .mono)
                                .offset(x: 40)
                                .frame(width: 100)
                            
                        }
                        .padding()
                        .frame(width: 300,  height: 50, alignment: .leading)
                        
                    }
                    
                }

            }
            .background(
                Color.white
            )
            .onAppear {
                collectionVM.prepareForSettingsMode()
                    withAnimation(.spring(dampingFraction: 1.0, blendDuration: 0.0)){
                        collectionVM.playAnimation.toggle()
                    }
                    withAnimation(.spring(dampingFraction: 1.0, blendDuration: 0.0).speed(0.4).delay(0.5)) {
                        collectionVM.playDelayedOpacityAnimation = true
                        collectionVM.playQuoteAnimation = true

                    }
//                print(collectionVM.currentCollection.quotes.indices)
//                print(collectionVM.currentIndex)
            }
    }
    
    @ViewBuilder
    private func topToolBar() -> some View {
        GeometryReader { proxy in
            HStack {
                
                ZStack(alignment: .leading) {
                    Button {
                        withAnimation {
                            collectionVM.createQuote()
                        }
                        
                    } label: {
                        
                            HStack {
                                Image(systemName: "plus")
                                
                                    .font(.system(size: 20))
                                Text("new quote")
                                    .customFont(15, .mono)
                            }
                            .foregroundColor(.black)
                        
                    }
                    .offset(y: collectionVM.settingsMode ? 0 : -50)
                    .opacity(collectionVM.settingsMode ? 1 : 0)
                    .animation(.spring(.smooth, blendDuration: 0.3), value: collectionVM.settingsMode)
                    
                    Button {
                            collectionIsOpen = false
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            withAnimation {
                                playBridgeAnimation = true
                            }
                        }
                    } label: {
                        Image("arrowImage")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .rotationEffect(.degrees(180))
                    }
                    .opacity(collectionVM.settingsMode ? 0 : 1)
                    .offset(x: collectionVM.settingsMode ? -100 : 0)
                    .animation(.spring(.smooth, blendDuration: 0.3), value: collectionVM.settingsMode)
                }
                
                Spacer()
                
                Button {
                    withAnimation(.default.speed(1.4)){
                        collectionVM.settingsMode.toggle()
                        if collectionVM.settingsMode {
                            collectionVM.prepareForSettingsMode()
//                            collectionVM.quote = collectionVM.quotes[collectionVM.currentIndex].quote
//                            collectionVM.whomQuote = collectionVM.quotes[collectionVM.currentIndex].whomQuote
                        } else {
                            collectionVM.updateData()
//                            collectionVM.quotes[collectionVM.currentIndex].quote = collectionVM.quote
//                            collectionVM.quotes[collectionVM.currentIndex].whomQuote = collectionVM.whomQuote
                        }
                    }
                } label: {
                    Image("moreImage")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.horizontal, 20)
            .frame(width: proxy.size.width, alignment: .center)
            
        }
    }
    
    @ViewBuilder
    private func rectangles() -> some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(0..<4, id: \.self) { index in
                    Rectangle()
                        .fill(rectangle.color)
                        .frame(width: 600, height: 600)
                        .offset(x: 55 , y: -85)
                        .rotationEffect(.degrees(-33), anchor: .topTrailing)
                        .rotationEffect(.degrees(collectionVM.playAnimation ? 83 : 0), anchor: .center)
                        .offset(x: collectionVM.playAnimation ? 150 : 0,
                                y: collectionVM.playAnimation ? -400 : 0)
                        .rotationEffect(.degrees(Double(6 * index)), anchor: .center)
                        .opacity(1 - 0.25 * Double(index))
                        .opacity(index == 0 ? 1 : collectionVM.playDelayedOpacityAnimation ? 1 : 0)
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

struct CllectionViewSketchToOriginal_Previews: PreviewProvider {
    static var previews: some View {
        @Environment(\.modelContext) var context
        
        CllectionView(collectionVM: CollectionVM(currentCollection: QuoteCollection(name: "", quotes: [], datestamp: .now), modelContext: context), collectionIsOpen: .constant(true), playBridgeAnimation: .constant(false), rectangle: CustomRectangle(changeId: .init(), color: LinearGradient(colors: [Color("Color7"), Color("Color8")], startPoint: .topLeading, endPoint: .bottomTrailing)))
    }
}





