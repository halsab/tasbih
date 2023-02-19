//
//  AppColorScheme.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI

enum AppColorScheme: String, CaseIterable, Identifiable, Codable {
    case system, light, dark
    
    var id: Self { self }
    
    var mode: ColorScheme? {
        switch self {
        case .system:
            return .none
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
}
