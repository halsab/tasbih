//
//  FooterView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 26.03.2024.
//

import SwiftUI

struct FooterView: View {

    @EnvironmentObject private var cm: CountManager

    private let bounceAnimationSpeed: Double = 1.3

    var body: some View {
        HStack {
            Button {
                cm.reset()
            } label: {
                Text(String.text.button.reset)
            }
            .padding()
            .buttonStyle(CustomButtonStyle())

            Spacer()

            HStack() {
                Button {
                    cm.isHapticEnabled.toggle()
                } label: {
                    Image(systemName: cm.isHapticEnabled ? .image.haptic.on : .image.haptic.off)
                        .font(.title)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.red)

                }
                .padding(8)
                .symbolEffect(.bounce.down, options: .speed(bounceAnimationSpeed), value: cm.isHapticEnabled)
                .contentTransition(.symbolEffect(.replace))

//                Button {
//                    cm.isSoundEnabled.toggle()
//                } label: {
//                    Image(systemName: cm.isSoundEnabled ? .image.sound.on : .image.sound.off)
//                        .font(.title)
//                        .symbolRenderingMode(.hierarchical)
//                        .foregroundStyle(.red)
//
//                }
//                .padding(8)
//                .symbolEffect(.bounce.down, options: .speed(bounceAnimationSpeed), value: cm.isSoundEnabled)
//                .contentTransition(.symbolEffect(.replace))
            }

            Spacer()
            
            Button {
                cm.undo()
            } label: {
                Text(String.text.button.undo)
            }
            .padding()
            .buttonStyle(CustomButtonStyle())
        }
    }
}

#Preview {
    FooterView()
        .environmentObject(CountManager())
        .padding()
        .preferredColorScheme(.dark)
}
