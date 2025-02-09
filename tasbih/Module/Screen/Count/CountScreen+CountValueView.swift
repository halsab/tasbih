//
//  CountScreen+CountValueView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct CountValueView: View {
        let count: Int
        
        var body: some View {
            Text(String(count))
                .contentTransition(.numericText())
                .font(.app.font(.xxxl, .bold))
                .foregroundStyle(Color.app.tint.secondary)
                .animation(.easeInOut, value: count)
        }
    }
}
