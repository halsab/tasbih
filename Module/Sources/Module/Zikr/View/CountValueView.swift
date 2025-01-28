//
//  CountValueView.swift
//  Module
//
//  Created by Khalil Sabirov on 28.01.2025.
//

import SwiftUI

struct CountValueView: View {
    let count: Int
    
    var body: some View {
        Text(String(count))
            .contentTransition(.numericText())
            .font(.app.font(.xxxl, .bold))
            .foregroundStyle(Color.app.tint)
    }
}

#Preview {
    CountValueView(count: 123)
}
