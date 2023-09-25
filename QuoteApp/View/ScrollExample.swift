//
//  ScrollExample.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 25/09/2023.
//

import SwiftUI

struct ScrollExample: View {
    
    @State var settingsMode: Bool = false
    @State var text = "Quotes for friends"
    
    var body: some View {
        VStack(alignment: .leading){
            Button {
                settingsMode.toggle()
            } label: {
                Image("moreImage")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            VStack(alignment: .leading) {
                Text("300")
                    .customFont(80, .halenoirOutline)
                    .padding(.leading, 10)
                    .offset(y: 60)
                
                VStack {
                    Text("Quotes for friends")
                        .customFont(15, .mono)
                        .frame(width: 200, height: 40)
                }
                
                    
            }
            .frame(width: 200, height: 200)
            
            
            
            VStack(alignment: .leading) {
                Text("300")
                    .customFont(110, .halenoir)
                    .padding(.leading, 10)
                    .offset(y: 80)

                
                if settingsMode {
                    TextField("Name of collection", text: $text)
                        .customFont(17, .mono)
                        .padding()
                        .frame(width: 240, height: 40, alignment: .leading)
                        
                        .background(
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                                
                        )
                } else {
                    Text("Quotes for friends")
                        .customFont(17, .mono)
                        .padding()
                        .frame(width: 240, height: 40, alignment: .leading)
                        
                }
            }
            .frame(width: 240, height: 50)
        }
    }
}

#Preview {
    ScrollExample()
}
