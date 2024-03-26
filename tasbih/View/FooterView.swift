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

    var body: some View {
        HStack {
            if cm.isAutoMode {
                HStack {
                    Slider(value: $cm.autoModeSpeed, in: cm.autoModeSpeedRange, step: 1)
                        .tint(.red)
                    Text(String(format: "%.0f", cm.autoModeSpeed))
                        .foregroundStyle(.red.gradient)
                        .font(.system(.body, design: .rounded, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 8))
                }
            } else {
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

                    Button {
                        cm.undo()
                    } label: {
                        Text("UNDO")
                    }
                    .padding()
                    .frame(width: buttonWidth)
                    .buttonStyle(CustomButtonStyle())

                    Spacer(minLength: minSpacerLength)
                }
            }

            Spacer(minLength: minSpacerLength)

            Button {
                withAnimation {
                    cm.isAutoMode.toggle()
                }
            } label: {
                Text(cm.isAutoMode ? "STOP" : "AUTO")
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
