//
//  TintColor.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI

enum TintColor: String, CaseIterable, Identifiable, Codable {
    case green, blue, orange, red, brown, indigo
    
    var id: Self { self }
    
    var color: Color {
        switch self {
        case .green:
            return .systemGreen
        case .blue:
            return .systemBlue
        case .orange:
            return .systemOrange
        case .red:
            return .systemRed
        case .brown:
            return .systemBrown
        case .indigo:
            return .systemIndigo
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
}
