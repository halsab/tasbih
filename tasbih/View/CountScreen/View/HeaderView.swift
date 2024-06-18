//
//  HeaderView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 24.03.2024.
//

import SwiftUI

struct HeaderView: View {

    @EnvironmentObject private var cm: CountManager

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
                Text("\(cm.loopSize)")
                    .foregroundStyle(Color.app.tint)
                    .font(.app.mTitle)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)
            }

            Spacer()

            RollingText(value: $cm.totalCounts,
                        font: .app.lTitle,
                        foregroundColor: Color.app.tint)
        }
    }
}

#Preview {
    HeaderView()
        .environmentObject(CountManager())
        .padding()
        .preferredColorScheme(.dark)
}
