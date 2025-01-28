//
//  TextButtonStyle.swift
//  tasbih
//
//  Created by Khalil Sabirov on 10.11.2023.
//

import SwiftUI
import Helper

public struct TextButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.shape(.app.tint).gradient)
            .font(.system(.body, design: .rounded, weight: .bold))
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
