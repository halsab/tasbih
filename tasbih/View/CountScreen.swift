//
//  CountScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.09.2023.
//

import SwiftUI

struct CountScreen: View {

    @StateObject var countManager = CountManager()

    @State private var beatAnimation = false
    @State private var showPulses = false
    @State private var pulsedHearts: [HeartParticleModel] = []

    var body: some View {
        VStack {
            ZStack {
                if showPulses {
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
                        .onChange(of: timeline.date) { oldValue, newValue in
                            if beatAnimation {
                                addPulsedHeart()
                            }
                        }
                    }
                }

                Image(systemName: "suit.heart.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.red.gradient)
                    .symbolEffect(.bounce, options: !beatAnimation ? .default : .repeating.speed(1), value: beatAnimation)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bar, in: .rect(cornerRadius: 24))
            .onChange(of: beatAnimation) { oldValue, newValue in
                if newValue {
                    showPulses = true
                    addPulsedHeart()
                }
            }

            Toggle("Beat Animation", isOn: $beatAnimation)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.bar, in: .rect(cornerRadius: 16))
                .padding(.top)
        }
        .environmentObject(countManager)
        .padding()
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
