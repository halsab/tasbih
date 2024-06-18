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
        Image(systemName: "suit.heart.fill")
            .font(.system(size: 100))
            .foregroundStyle(.red)
            .background(content: {
                Image(systemName: "suit.heart.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.black)
                    .blur(radius: 5, opaque: false)
                    .scaleEffect(startAnimation ? 1.1 : 0)
                    .animation(.linear(duration: 1.5), value: startAnimation)
            })
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
