//
//  HomeSketch2.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 03/09/2023.
//

import SwiftUI

struct HomeSketch2: View {
    
    @Namespace var animation
    
    @State var playAnimation: Bool = false
    
    let arrayOfNumbers: [Int] = [7, 6, 5, 4, 3, 2, 1]
    var sizeOfNumbers: [CGFloat] {
        var sorted: [CGFloat] = []
        for number in arrayOfNumbers {
            sorted.append(textSize(String(describing: number)))
        }
        return sorted
    }
    
    var fontSize: CGFloat = 32
    
    
    
    @State var currentIndex: Int = 0
    @State var offsetOfCurrentIndex: CGFloat = 0
    
    
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(arrayOfNumbers.reversed(), id: \.self) { num in
                    RowView(number: num, currentIndex: currentIndex)
                        .offset(y: -300)
                }
            }
            .onAppear {

            }
        }
    }
    
    @ViewBuilder
    func RowView(number: Int, currentIndex: Int) -> some View {
        if  arrayOfNumbers[currentIndex] == number {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 40)
                Text(String(describing: number))
                    .font(.system(size: 100))
                    .offset(y: offsetOfCurrentIndex)

                    

                    .gesture(
                        DragGesture(minimumDistance: 0.6)
                            .onChanged({ value in
                                self.offsetOfCurrentIndex = value.translation.height / 3.5
                                playAnimation = false
                            })
                            .onEnded({ value in
                                if offsetOfCurrentIndex > 26 {
                                    withAnimation(.easeOut(duration: 0.5)){
                                        self.offsetOfCurrentIndex = 0
                                        self.currentIndex += 1
                                    }
                                } else {
                                    withAnimation {
                                        self.offsetOfCurrentIndex = 0
                                    }
                                }
                            })
                    )
                Text("quotes from friends")
            }
            .frame(width: 200, height: 200)
            .matchedGeometryEffect(id: number, in: animation)

            
            .offset(y: 120 * Double(currentIndex))
            
        } else {
            VStack(alignment: .leading) {
                Text(String(describing: number))
                    .font(.system(size: 70))
                Text("quotes from friends")
            }
            .frame(width: 200, height: 120)
            .matchedGeometryEffect(id: number, in: animation)
            .offset(y: 125 * Double(currentIndex))
        }
    }
        
    
}




struct HomeSketch2_Previews: PreviewProvider {
    static var previews: some View {
        HomeSketch2()
    }
}


func textSize(_ text: String) -> CGFloat {
    return NSString(string: text).size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle)]).width
}
