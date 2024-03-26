//
//  HeaderView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 24.03.2024.
//

import SwiftUI

struct HeaderView: View {

    @EnvironmentObject private var cm: CountManager

    private let bounceAnimationSpeed: Double = 1.3

    var body: some View {
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
                VStack(spacing: -8) {
                    RollingText(
                        value: $cm.currentLoopCount,
                        font: .system(.body, design: .rounded, weight: .bold),
                        foregroundColor: Color.red
                    )
                    .padding(12)

                    Text("\(cm.loopSize)")
                        .foregroundStyle(Color.primary)
                        .font(.system(.footnote, design: .rounded, weight: .bold))
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .background(.red)
                        .clipShape(.capsule)
                }
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 8))
            }

            Spacer(minLength: 0)

            HStack() {
                Button {
                    cm.isDesignMode.toggle()
                } label: {
                    Image(systemName: "wand.and.rays")
                        .font(.title)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.red)

                }
                .padding(8)
                .symbolEffect(.bounce.down, options: .speed(bounceAnimationSpeed), value: cm.isDesignMode)

                Button {
                    cm.isHapticEnabled.toggle()
                } label: {
                    Image(systemName: cm.isHapticEnabled
                          ? "iphone.radiowaves.left.and.right.circle.fill"
                          : "iphone.radiowaves.left.and.right.circle"
                    )
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.red)

                }
                .padding(8)
                .symbolEffect(.bounce.down, options: .speed(bounceAnimationSpeed), value: cm.isHapticEnabled)
                .contentTransition(.symbolEffect(.replace))

                Button {
                    cm.isSoundEnabled.toggle()
                } label: {
                    Image(systemName: cm.isSoundEnabled
                          ? "speaker.wave.2.circle.fill"
                          : "speaker.wave.2.circle"
                    )
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.red)

                }
                .padding(8)
                .symbolEffect(.bounce.down, options: .speed(bounceAnimationSpeed), value: cm.isSoundEnabled)
                .contentTransition(.symbolEffect(.replace))
            }

            Spacer(minLength: 0)

            RollingText(value: $cm.totalCounts,
                        font: .system(.largeTitle, design: .rounded, weight: .bold),
                        foregroundColor: Color.red)
        }
    }
}

#Preview {
    HeaderView()
        .environmentObject(CountManager())
        .padding()
}
