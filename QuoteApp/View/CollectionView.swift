//
//  CollectionView.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 16/09/2023.
//

import SwiftUI

struct CollectionView: View {
    
    @Environment(\.openURL) private var openURL
    @StateObject var collectionVM =  CollectionVM()
    var gri = LinearGradient(colors: [Color("Color7"), Color("Color8")], startPoint: .topLeading, endPoint: .bottomTrailing)
    

    var body: some View {
//        NavigationView {
            ZStack {
                
                
                //MARK: Rectangle
                ForEach(0..<4, id: \.self) { index in
                    Rectangle()
                        .fill(gri)
                        .frame(width: 600, height: 600)
                        .offset(x: 50 , y: -45)
                        .rotationEffect(.degrees(-33), anchor: .topTrailing)
                        .rotationEffect(.degrees(collectionVM.playAnimation ? 83 : 0), anchor: .center)
                        .offset(x: collectionVM.playAnimation ? 150 : 0,
                                y: collectionVM.playAnimation ? -400 : 0)
                        .rotationEffect(.degrees(Double(6 * index)), anchor: .center)
                        .opacity(1 - 0.25 * Double(index))
                        .opacity(index == 0 ? 1 : collectionVM.playDelayedOpacityAnimation ? 1 : 0)
                }
                
                
                VStack(spacing: 30) {
                    
                        VStack(alignment: .leading) {
                            
                            Text("''")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                                .offset(y: 50)
                                .offset(y: collectionVM.draggOffset)
                            

                                    TextField("Quote..", text: $collectionVM.quote, axis: .vertical)
                                        .disabled(!collectionVM.settingsMode)
                                        .customFont(27, .mono)
                                        .frame(width: 300, height: 280, alignment: .topLeading)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(lineWidth: 1)
                                                .opacity(collectionVM.settingsMode ? 1 : 0)
                                        )
                                        .offset(y: collectionVM.draggOffset)
                                        .overlay {
                                            if !collectionVM.settingsMode {
                                                Color.white.opacity(0.01)
                                                    .gesture(DragGesture(coordinateSpace: .global)
                                                        .onChanged({ value in
                                                            withAnimation(){
                                                                collectionVM.draggOffset = value.translation.height / 3
                                                            }
                                                        })
                                                             //MARK: Write funk to this
                                                        .onEnded({ value in
                                                            withAnimation() {
                                                                if collectionVM.draggOffset > 40 {
                                                                    collectionVM.draggOffset = 0
                                                                    collectionVM.currentIndex += 1
                                                                    collectionVM.quote = collectionVM.quotes[collectionVM.currentIndex].quote
                                                                    collectionVM.whomQuote = collectionVM.quotes[collectionVM.currentIndex].whomQuote
                                                                } else  if collectionVM.draggOffset < -35{
                                                                    collectionVM.draggOffset = 0
                                                                    collectionVM.currentIndex -= 1
                                                                    collectionVM.quote = collectionVM.quotes[collectionVM.currentIndex].quote
                                                                    collectionVM.whomQuote = collectionVM.quotes[collectionVM.currentIndex].whomQuote
                                                                } else {
                                                                    collectionVM.draggOffset = 0
                                                                }
                                                            }
                                                        })
                                                    )
                                                
                                            }
                                        }
                            
                            
                                
                            
                            TextField("Whom quote?", text: $collectionVM.whomQuote)
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
                            Text("03 MAR 2020")
                            Text("12.52.03")
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
                            if collectionVM.wantToDelete {
                                Button {
                                    collectionVM.quotes.remove(at: collectionVM.currentIndex)
                                    withAnimation {
                                        collectionVM.quote = collectionVM.quotes[collectionVM.currentIndex].quote
                                        collectionVM.whomQuote = collectionVM.quotes[collectionVM.currentIndex].whomQuote
                                    }
                                    print("removed")
                                } label: {
                                    Image("checkmarkImage")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                }
                            } else {
                                ShareLink(item: collectionVM.quote) {
                                    Image("shareImage")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .offset(y: collectionVM.wantToDelete ? -5 : 0)
                                }
                            }
                            Button {
                                
                                    collectionVM.wantToDelete.toggle()
                                
                                
                            } label: {
                                Image(collectionVM.wantToDelete ? "crossImage" : "trashImage")
                                    .resizable()
                                    .frame(width: collectionVM.wantToDelete ? 40 : 35, height: collectionVM.wantToDelete ? 45 : 35)
                                    .offset(x: collectionVM.wantToDelete ? -1 : 0, y: collectionVM.wantToDelete ? 4 : 2)
                            }
                            .frame(width: 50)
                                
                            
                            Text("\(collectionVM.currentIndex)/\(collectionVM.quotes.count - 1)")
                                .customFont(18, .mono)
                                .offset(x: 40)
                                .frame(width: 100)
                            
                        }
                        .padding()
                        .frame(width: 300,  height: 50, alignment: .leading)
                        
                    }
                    
                }
            }
            .onAppear {
                collectionVM.whomQuote = collectionVM.quotes[collectionVM.currentIndex].whomQuote
                collectionVM.quote = collectionVM.quotes[collectionVM.currentIndex].quote
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.spring(dampingFraction: 1.0, blendDuration: 0.0)){
                        collectionVM.playAnimation.toggle()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring(dampingFraction: 1.0, blendDuration: 0.0).speed(0.4)) {
                        collectionVM.playDelayedOpacityAnimation = true
                        collectionVM.playQuoteAnimation = true
                        
                    }
                }
            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        if collectionVM.settingsMode {
//                            withAnimation {
//                                collectionVM.quotes.append(QuoteExample(quote: "", whomQuote: ""))
//                                collectionVM.currentIndex = collectionVM.quotes.count - 1
//                                collectionVM.quote = collectionVM.quotes[collectionVM.currentIndex].quote
//                                collectionVM.whomQuote = collectionVM.quotes[collectionVM.currentIndex].whomQuote
//                            }
//                            print(collectionVM.quotes.count)
//                        } else {
////                            shouldCloseQuoteView = true
//                        }
//
//                    } label: {
//                        if collectionVM.settingsMode {
//                            HStack {
//                                Image(systemName: "plus")
//
//                                    .font(.system(size: 20))
//                                Text("new quote")
//                                    .customFont(15, .mono)
//                            }
//                            .foregroundColor(.black)
//                        } else {
//                            Image("arrowImage")
//                                .resizable()
//                                .frame(width: 24, height: 24)
//                                .rotationEffect(.degrees(180))
//
//                        }
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        withAnimation(.default.speed(1.4)){
//                            collectionVM.settingsMode.toggle()
//                        }
//                    } label: {
//                        Image("moreImage")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                    }
//
//                }
//            }
//        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}



//VStack {
//    ForEach(collectionVM.quotes, id: \.self) { quote in
//    }
//    .frame(height: 280)
//}
//.frame(height: 280)
