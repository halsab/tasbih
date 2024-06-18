//
//  FooterView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 26.03.2024.
//

import SwiftUI

struct FooterView: View {

    @EnvironmentObject private var cm: CountManager

    private let buttonWidth: CGFloat = 90
    private let minSpacerLength: CGFloat = 0
    private let bounceAnimationSpeed: Double = 1.3

    var body: some View {
        HStack {
            Button {
                cm.reset()
            } label: {
                Text("RESET")
            }
            .padding()
            .frame(width: buttonWidth)
            .buttonStyle(CustomButtonStyle())

            Spacer(minLength: minSpacerLength)

            HStack() {
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

            Spacer(minLength: minSpacerLength)

            Button {
                cm.undo()
            } label: {
                Text("UNDO")
            }
            .padding()
            .frame(width: buttonWidth)
            .buttonStyle(CustomButtonStyle())
        }
    }
}

#Preview {
    FooterView()
        .environmentObject(CountManager())
        .padding()
}
