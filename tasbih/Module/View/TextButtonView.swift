//
//  TextButtonView.swift
//  ViewUI
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

struct TextButtonView: View {
    let text: String
    let alignment: HorizontalAlignment
    let action: () -> Void
    
    @Environment(\.isEnabled) private var isEnabled
    
    init(text: String, alignment: HorizontalAlignment = .center, action: @escaping () -> Void) {
        self.text = text
        self.alignment = alignment
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                if alignment == .trailing {
                    Spacer(minLength: 0)
                }
                Text(text)
                    .foregroundStyle(
                        Color.shape(isEnabled ? .app.tint.primary : .secondary).gradient
                    )
                    .font(.app.font(.m, weight: .bold))
                    .lineLimit(1)
                if alignment == .leading {
                    Spacer(minLength: 0)
                }
            }
        }
    }
}

#Preview {
    TextButtonView(text: "Button".uppercased(), action: {})
}
