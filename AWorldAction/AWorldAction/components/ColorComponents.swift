//
//  ColorComponents.swift
//  AWorldAction
//
//  Created by Andrea Sala on 04/05/23.
//

import Foundation
import SwiftUI

struct ColorComponents {
    
    private(set) static var green = colorFromRGB(r: 57, g: 181, b: 74)
    private(set) static var lightGreen = colorFromRGB(r: 140, g: 198, b: 63)
    private(set) static var lightGray = colorFromRGB(r: 233, g: 233, b: 233)
    
    static func colorFromRGB(r: Int, g: Int, b: Int) -> Color {
        let red = Double(r)
        let green = Double(g)
        let blue = Double(b)
        return Color(red: red / 255, green: green / 255, blue: blue / 255)
    }
}
