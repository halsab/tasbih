//
//  Color+extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import SwiftUI

public extension Color {
    private static func moduleColor(_ name: String) -> Color {
        Color(name, bundle: .module)
    }
    
    enum app {
        public static let tint: Color = moduleColor("tint")
        public static let highlight: Color = moduleColor("highlight")
    }
}
