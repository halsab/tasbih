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
            HStack {
                RollingText(value: $cm.totalCounts,
                            font: .app.lTitle,
                            foregroundColor: Color.app.tint)

                Spacer()

                Menu {
                    ForEach(LoopSize.allCases, id: \.self) { loopSize in
                        Button {
                            cm.loopSize = loopSize
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

            switch cm.loopSize {
            case .infinity:
                EmptyView()
            default:
                ProgressView(value: Double(cm.currentLoopCount), total: Double(cm.loopSize.rawValue))
                    .tint(.app.tint)
                    .animation(.easeInOut, value: cm.currentLoopCount)
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
