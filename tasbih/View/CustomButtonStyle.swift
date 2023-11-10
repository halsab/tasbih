//
//  CustomButtonStyle.swift
//  tasbih
//
//  Created by Khalil Sabirov on 10.11.2023.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.red.gradient)
            .font(.system(.body, design: .rounded, weight: .bold))
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
    }
}
