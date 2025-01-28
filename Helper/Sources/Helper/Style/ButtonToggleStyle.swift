//
//  File.swift
//  AppUIKit
//
//  Created by Khalil Sabirov on 09.11.2024.
//

import SwiftUI

public struct FilterToggleStyle: ToggleStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isOn.toggle()
            }
        } label: {
            configuration.label
                .font(.app.font(.s))
                .foregroundStyle(Color.app.tint)
        }
        .padding(.vertical, 2)
        .padding(.horizontal, 4)
        .background(Color.app.tint.opacity(configuration.isOn ? 0.15 : 0))
        .clipShape(.capsule)
    }
}
