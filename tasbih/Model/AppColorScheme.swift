//
//  AppColorScheme.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI

enum AppColorScheme: String, CaseIterable, Identifiable, Codable {
    case light, dark, system
    
    var id: Self { self }
    
    var mode: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .none
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
}
