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
        VStack(spacing: 6) {
            switch cm.loopSize {
            case .infinity:
                EmptyView()
            default:
                ProgressView(value: Double(cm.currentLoopCount), total: Double(cm.loopSize.rawValue)) {
                    HStack {
                        Text("\(cm.currentLoopCount)")
                        Spacer()
                        Text("x\(cm.loopsCount)")
                    }
                    .font(.app.footnote)
                    .foregroundStyle(Color.app.tint)
                    .monospaced()
                }
                .tint(.app.tint)
                .animation(.easeInOut, value: cm.currentLoopCount)
            }

            HStack {
                Text(String(cm.totalCounts))
                    .animation(.easeInOut, value: cm.totalCounts)
                    .font(.app.lTitle)
                    .foregroundStyle(Color.app.tint)

                Spacer()

                Menu {
                    ForEach(LoopSize.allCases, id: \.self) { loopSize in
                        Button {
                            cm.loopSize = loopSize
                            cm.totalCounts = cm.totalCounts
                        } label: {
                            Label(loopSize.title,
                                  systemImage: cm.loopSize == loopSize
                                  ? loopSize.selectedIconName : "")
                        }
                    }
                } label: {
                    Text(cm.loopSize.shortTitle)
                        .foregroundStyle(Color.app.tint)
                        .font(.app.mTitle)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(.ultraThinMaterial)
                        .clipShape(.capsule)
                }
            }
        }
    }
}

#Preview {
    HeaderView()
        .environmentObject(CountManager())
        .padding()
        .preferredColorScheme(.dark)
}
