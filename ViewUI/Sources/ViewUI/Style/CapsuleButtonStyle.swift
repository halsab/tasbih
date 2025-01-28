//
//  CapsuleButtonStyle.swift
//  AppUIKit
//
//  Created by Khalil Sabirov on 10.11.2024.
//

import SwiftUI
import Helper

public struct CapsuleButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.white)
            .font(.app.font(.m))
            .padding()
            .background(Color.app.tint)
            .clipShape(.capsule)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
