//
//  CountValueView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 15.02.2025.
//

import SwiftUI

struct CountValueView: View {
    let count: Int
    
    var body: some View {
        Text(String(count))
            .contentTransition(.numericText())
            .font(.app.font(.xxl, weight: .bold))
            .foregroundStyle(Color.app.tint.secondary)
            .animation(.easeInOut, value: count)
    }
}

#Preview {
    CountValueView(count: 123)
}
