//
//  PulsedHeartView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.09.2023.
//

import SwiftUI

struct PulsedHeartView: View {

    @State private var startAnimation = false
    
    var body: some View {
        Image(systemName: .image.button.count)
            .font(.system(size: 100))
            .foregroundStyle(.red)
            .scaleEffect(startAnimation ? 4 : 1)
            .opacity(startAnimation ? 0 : 0.7)
            .onAppear(perform: {
                withAnimation(.linear(duration: 3)) {
                    startAnimation = true
                }
            })
    }
}

#Preview {
    PulsedHeartView()
        .preferredColorScheme(.dark)
}
