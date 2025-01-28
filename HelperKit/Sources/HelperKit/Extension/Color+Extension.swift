//
//  Color+Extension.swift
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
        public static let tint = moduleColor("tint")
        public static let highlight = moduleColor("highlight")
        
        public enum bg {
            public static let sura = moduleColor("bg/sura")
        }
    }
    
    enum system {
        public static let red: Color = .init(uiColor: .systemRed)
        public static let green: Color = .init(uiColor: .systemGreen)
        public static let blue: Color = .init(uiColor: .systemBlue)
        public static let orange: Color = .init(uiColor: .systemOrange)
        public static let yellow: Color = .init(uiColor: .systemYellow)
        public static let pink: Color = .init(uiColor: .systemPink)
        public static let purple: Color = .init(uiColor: .systemPurple)
        public static let teal: Color = .init(uiColor: .systemTeal)
        public static let indigo: Color = .init(uiColor: .systemIndigo)
        public static let brown: Color = .init(uiColor: .systemBrown)
        public static let mint: Color = .init(uiColor: .systemMint)
        public static let cyan: Color = .init(uiColor: .systemCyan)
        public static let gray: Color = .init(uiColor: .systemGray)
        public static let gray2: Color = .init(uiColor: .systemGray2)
        public static let gray3: Color = .init(uiColor: .systemGray3)
        public static let gray4: Color = .init(uiColor: .systemGray4)
        public static let gray5: Color = .init(uiColor: .systemGray5)
        public static let gray6: Color = .init(uiColor: .systemGray6)
        public static let tintColor: Color = .init(uiColor: .tintColor)
        public static let label: Color = .init(uiColor: .label)
        public static let secondaryLabel: Color = .init(uiColor: .secondaryLabel)
        public static let tertiaryLabel: Color = .init(uiColor: .tertiaryLabel)
        public static let quaternaryLabel: Color = .init(uiColor: .quaternaryLabel)
        public static let link: Color = .init(uiColor: .link)
        public static let placeholderText: Color = .init(uiColor: .placeholderText)
        public static let separator: Color = .init(uiColor: .separator)
        public static let opaqueSeparator: Color = .init(uiColor: .opaqueSeparator)
        public static let background: Color = .init(uiColor: .systemBackground)
        public static let secondaryBackground: Color = .init(uiColor: .secondarySystemBackground)
        public static let tertiaryBackground: Color = .init(uiColor: .tertiarySystemBackground)
        public static let groupedBackground: Color = .init(uiColor: .systemGroupedBackground)
        public static let secondaryGroupedBackground: Color = .init(uiColor: .secondarySystemGroupedBackground)
        public static let tertiaryGroupedBackground: Color = .init(uiColor: .tertiarySystemGroupedBackground)
        public static let fill: Color = .init(uiColor: .systemFill)
        public static let secondaryFill: Color = .init(uiColor: .secondarySystemFill)
        public static let tertiaryFill: Color = .init(uiColor: .tertiarySystemFill)
        public static let quaternaryFill: Color = .init(uiColor: .quaternarySystemFill)
        public static let lightText: Color = .init(uiColor: .lightText)
        public static let darkText: Color = .init(uiColor: .darkText)
    }
}
