//
//  PulsedHeartView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

struct PulsedHeartView: View {
    
    @State private var startAnimation = false
    
    var body: some View {
        Image.app.button.count
            .font(.system(size: 100))
            .foregroundStyle(Color.shape(.app.tint.tertiary))
            .scaleEffect(startAnimation ? 4 : 1)
            .opacity(startAnimation ? 0 : 0.7)
            .onAppear {
                withAnimation(.linear(duration: 3)) {
                    startAnimation = true
                }
            }
    }
}

#Preview {
    PulsedHeartView()
        .preferredColorScheme(.dark)
}
