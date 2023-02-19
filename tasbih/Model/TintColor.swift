//
//  TintColor.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI

enum TintColor: String, CaseIterable, Identifiable, Codable {
    case monochrome
    case gray
    case red
    case green
    case blue
    case orange
    case yellow
    case pink
    case purple
    case teal
    case indigo
    case brown
    case mint
    case cyan
    
    var id: Self { self }
    
    var color: Color {
        switch self {
        case .monochrome:
            return .primary
        case .gray:
            return .gray3
        case .red:
            return .systemRed
        case .green:
            return .systemGreen
        case .blue:
            return .systemBlue
        case .orange:
            return .systemOrange
        case .yellow:
            return .systemYellow
        case .pink:
            return .systemPink
        case .purple:
            return .systemPurple
        case .teal:
            return .systemTeal
        case .indigo:
            return .systemIndigo
        case .brown:
            return .systemBrown
        case .mint:
            return .systemMint
        case .cyan:
            return .systemCyan
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
}
