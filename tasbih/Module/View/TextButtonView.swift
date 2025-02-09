//
//  TextButtonView.swift
//  ViewUI
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

struct TextButtonView: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundStyle(Color.shape(.app.tint.primary).gradient)
                .font(.app.font(.m, .bold))
        }
    }
}

#Preview {
    TextButtonView(text: "Button", action: {})
}
