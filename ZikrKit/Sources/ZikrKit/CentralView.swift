//
//  CentralView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 26.03.2024.
//

import SwiftUI

struct CentralView: View {

    @Bindable var zikr: ZikrModel
    @State private var pulsedHearts: [HeartParticleModel] = []
    @Environment(\.modelContext) private var modelContext
    @AppStorage(.storageKey.common.haptic) var isHapticEnabled = false
    
    private let hardHapticFeedback = UINotificationFeedbackGenerator()
    private let softHapticFeedback = UIImpactFeedbackGenerator(style: .soft)

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
                .symbolEffect(.bounce, options: .nonRepeating.speed(2), value: zikr.count)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            withAnimation {
                zikr.count += 1
                zikr.date = .now
                hapticFeedback()
                addPulsedHeart()
                try? modelContext.save()
            }
        }
    }

    private func addPulsedHeart() {
        let pulsedHeart = HeartParticleModel()
        pulsedHearts.append(pulsedHeart)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            pulsedHearts.removeAll(where: { $0.id == pulsedHeart.id })
        }
    }
    
    private func hapticFeedback() {
        guard isHapticEnabled else { return }
        if zikr.currentLoopCount == 0 {
            hardHapticFeedback.notificationOccurred(.success)
        } else {
            softHapticFeedback.impactOccurred()
            softHapticFeedback.prepare()
        }
    }
}

#Preview {
    CentralView(zikr: .init(name: "Zikr"))
        .padding()
}
