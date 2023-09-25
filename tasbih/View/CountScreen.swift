//
//  CountScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.09.2023.
//

import SwiftUI

struct CountScreen: View {

    @StateObject var cm = CountManager()

    @State private var pulsedHearts: [HeartParticleModel] = []

    var body: some View {
        VStack {
            ZStack {
                TimelineView(.animation(minimumInterval: 0.7, paused: false)) { timeline in
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

                Image(systemName: "suit.heart.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.red.gradient)
                    .symbolEffect(.bounce, options: .nonRepeating.speed(1.5), value: cm.countValue)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                cm.countValue += 1
                addPulsedHeart()
            }
        }
        .environmentObject(cm)
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
    CountScreen()
        .environmentObject(CountManager())
        .preferredColorScheme(.dark)
}
