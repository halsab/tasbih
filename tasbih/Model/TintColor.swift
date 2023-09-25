//
//  TintColor.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI

enum TintColor: String, CaseIterable, Identifiable, Codable {
    case monochrome
    
    var id: Self { self }
    
    var color: Color {
        switch self {
        case .monochrome:
            return .primary
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
}
