//
//  Fonts.swift
//  QuoteApp
//
//  Created by Yaroslav Sokolov on 09/09/2023.
//

import Foundation
import SwiftUI



enum ImportFonts: String {
    
    case mono = "ApproachMonoTRIAL-Md"
    case halenoir = "Halenoir-Black"
    case halenoirOutline = "Halenoir-BlackOutline"
    
}

extension View {
    func customFont(_ size: CGFloat, _ font: ImportFonts) -> some View {
        self
            .font(.custom(font.rawValue, size: size))
    }
}
