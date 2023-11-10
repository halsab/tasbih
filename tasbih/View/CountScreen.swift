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
            HStack {
                Menu {
                    ForEach(LoopSize.allCases, id: \.self) { loopSize in
                        Button {
                            cm.loopSize = loopSize.rawValue
                        } label: {
                            Label(loopSize.title,
                                  systemImage: cm.loopSize == loopSize.rawValue
                                  ? loopSize.selectedIconName : "")
                        }
                    }
                } label: {
                    HStack(spacing: 0) {
                        Text("\(cm.loopSize) /  ")
                            .foregroundStyle(Color.gray)
                            .font(.system(.body, design: .rounded, weight: .bold))
                            .monospacedDigit()
                        RollingText(value: $cm.currentLoopCount,
                                    font: .system(.body, design: .rounded, weight: .bold),
                                    foregroundColor: Color.red)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 8))
                }
                .animation(.smooth(duration: 0.25, extraBounce: 0.8), value: cm.loopSize)

                Spacer()
                
                RollingText(value: $cm.totalCounts,
                            font: .system(.largeTitle, design: .rounded, weight: .bold),
                            foregroundColor: Color.red)
            }
            .padding()

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

                Image(systemName: "suit.heart.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.red.gradient)
                    .symbolEffect(.bounce, options: .nonRepeating.speed(2), value: cm.totalCounts)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                cm.totalCounts += 1
                addPulsedHeart()
            }

            Button {
                cm.totalCounts = 0
            } label: {
                Text("RESET")
            }
            .buttonStyle(CustomButtonStyle())
            .padding(.horizontal)
            .padding(.bottom)

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
