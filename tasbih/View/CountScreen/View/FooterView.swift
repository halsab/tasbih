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
        }
    }
}

#Preview {
    FooterView()
        .environmentObject(CountManager())
        .padding()
}
