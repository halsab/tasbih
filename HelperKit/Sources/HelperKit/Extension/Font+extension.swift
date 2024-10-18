//
//  Font+extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import SwiftUI

public extension Font {
    enum app {
        public static let mBody: Font = .system(.body, design: .rounded, weight: .regular)
        public static let mTitle: Font = .system(.body, design: .rounded, weight: .bold)
        public static let lTitle: Font = .system(.largeTitle, design: .rounded, weight: .bold)
        public static let footnote: Font = .system(.footnote, design: .rounded, weight: .light)
    }
}
