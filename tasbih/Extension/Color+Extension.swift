//
//  Color+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import SwiftUI

extension Color {
    enum app {
        static let tint = Color("tint")
        static let highlight = Color("highlight")
    }
    
    enum system {
        static let red: Color = .init(uiColor: .systemRed)
        static let green: Color = .init(uiColor: .systemGreen)
        static let blue: Color = .init(uiColor: .systemBlue)
        static let orange: Color = .init(uiColor: .systemOrange)
        static let yellow: Color = .init(uiColor: .systemYellow)
        static let pink: Color = .init(uiColor: .systemPink)
        static let purple: Color = .init(uiColor: .systemPurple)
        static let teal: Color = .init(uiColor: .systemTeal)
        static let indigo: Color = .init(uiColor: .systemIndigo)
        static let brown: Color = .init(uiColor: .systemBrown)
        static let mint: Color = .init(uiColor: .systemMint)
        static let cyan: Color = .init(uiColor: .systemCyan)
        static let gray: Color = .init(uiColor: .systemGray)
        static let gray2: Color = .init(uiColor: .systemGray2)
        static let gray3: Color = .init(uiColor: .systemGray3)
        static let gray4: Color = .init(uiColor: .systemGray4)
        static let gray5: Color = .init(uiColor: .systemGray5)
        static let gray6: Color = .init(uiColor: .systemGray6)
        static let tintColor: Color = .init(uiColor: .tintColor)
        static let label: Color = .init(uiColor: .label)
        static let secondaryLabel: Color = .init(uiColor: .secondaryLabel)
        static let tertiaryLabel: Color = .init(uiColor: .tertiaryLabel)
        static let quaternaryLabel: Color = .init(uiColor: .quaternaryLabel)
        static let link: Color = .init(uiColor: .link)
        static let placeholderText: Color = .init(uiColor: .placeholderText)
        static let separator: Color = .init(uiColor: .separator)
        static let opaqueSeparator: Color = .init(uiColor: .opaqueSeparator)
        static let background: Color = .init(uiColor: .systemBackground)
        static let secondaryBackground: Color = .init(uiColor: .secondarySystemBackground)
        static let tertiaryBackground: Color = .init(uiColor: .tertiarySystemBackground)
        static let groupedBackground: Color = .init(uiColor: .systemGroupedBackground)
        static let secondaryGroupedBackground: Color = .init(uiColor: .secondarySystemGroupedBackground)
        static let tertiaryGroupedBackground: Color = .init(uiColor: .tertiarySystemGroupedBackground)
        static let fill: Color = .init(uiColor: .systemFill)
        static let secondaryFill: Color = .init(uiColor: .secondarySystemFill)
        static let tertiaryFill: Color = .init(uiColor: .tertiarySystemFill)
        static let quaternaryFill: Color = .init(uiColor: .quaternarySystemFill)
        static let lightText: Color = .init(uiColor: .lightText)
        static let darkText: Color = .init(uiColor: .darkText)
    }
}
