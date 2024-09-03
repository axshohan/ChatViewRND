//
//  Extension.swift
//  GoChat
//
//  Created by Shohan Ahmed on 28/8/24.
//

import Foundation
import SwiftUI

extension Binding where Value == String {
    func limit(_ length: Int) -> Binding<String> {
        return Binding(
            get: {
                return self.wrappedValue
            },
            set: { newValue in
                if newValue.count <= length {
                    self.wrappedValue = newValue
                } else {
                    // Truncate the input to the allowed length
                    self.wrappedValue = String(newValue.prefix(length))
                }
            }
        )
    }
}

extension Color {
    static let axBlue = Color(hex: "#175697")
    static let midNightBlue = Color(hex: "#D3DDEC")
    static let chatbg = Color(hex: "#F1F1F1")
    static let chatDate = Color(hex: "#9B9B9B")
    static let softBlue = Color(hex: "#CDE4FF")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
