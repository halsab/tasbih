//
//  FooterView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 26.03.2024.
//

import SwiftUI
import AppUIKit

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

            Button {
                cm.isHapticEnabled.toggle()
            } label: {
                (cm.isHapticEnabled ? Image.app.haptic.on : Image.app.haptic.off)
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.shape(.app.tint))

            }
            .padding(8)
            .symbolEffect(.bounce.down, options: .speed(bounceAnimationSpeed), value: cm.isHapticEnabled)
            .contentTransition(.symbolEffect(.replace))

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
