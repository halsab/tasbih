//
//  SwiftUIView.swift
//  Module
//
//  Created by Khalil Sabirov on 28.01.2025.
//

import SwiftUI

struct CountProgressView: View {
    let currentLoopCount: Int
    let loopsCount: Int
    let zikrName: String
    let loopSize: LoopSize
    
    var body: some View {
        Gauge(
            value: Double(currentLoopCount),
            in: 0...Double(loopSize.rawValue)
        ) {
            HStack {
                Text("\(currentLoopCount)")
                    .contentTransition(.numericText())
                Spacer()
                Text("x\(loopsCount)")
            }
            .font(.app.font(.m))
            .foregroundStyle(Color.app.tint)
            .monospaced()
            .overlay(alignment: .centerFirstTextBaseline) {
                ZikrNameView(name: zikrName)
            }
        }
        .tint(.app.tint)
        .animation(.easeInOut, value: currentLoopCount)
    }
}

#Preview {
    CountProgressView(
        currentLoopCount: 13,
        loopsCount: 4,
        zikrName: "Zikr name",
        loopSize: .s
    )
    .safeAreaPadding()
}
