//
//  CentralView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 26.03.2024.
//

import SwiftUI

struct CentralView: View {

    @EnvironmentObject private var cm: CountManager
    
    @State private var pulsedHearts: [HeartParticleModel] = []

    var body: some View {
        ZStack {
            TimelineView(.animation(minimumInterval: 0.5, paused: false)) { timeline in
                Canvas { context, size in
                    for heart in pulsedHearts {
                        if let resolvedView = context.resolveSymbol(id: heart.id) {
                            let centerX = size.width / 2
                            let centerY = size.height / 2

                            context.draw(resolvedView, at: .init(x: centerX, y: centerY))
                        }
                    }
                } symbols: {
                    ForEach(pulsedHearts) {
                        PulsedHeartView()
                            .id($0.id)
                    }
                }
            }
            .blur(radius: 15)

            Image.app.button.count
                .font(.system(size: 100))
                .foregroundStyle(Color.shape(.app.tint))
                .symbolEffect(.bounce, options: .nonRepeating.speed(2), value: cm.totalCounts)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            cm.totalCounts += 1
            addPulsedHeart()
        }
    }

    private func addPulsedHeart() {
        let pulsedHeart = HeartParticleModel()
        pulsedHearts.append(pulsedHeart)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            pulsedHearts.removeAll(where: { $0.id == pulsedHeart.id })
        }
    }
}

#Preview {
    CentralView()
        .environmentObject(CountManager())
        .padding()
}
