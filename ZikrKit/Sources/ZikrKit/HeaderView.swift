//
//  HeaderView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 24.03.2024.
//

import SwiftUI

struct HeaderView: View {

    @Bindable var zikr: ZikrModel

    var body: some View {
        VStack(spacing: 6) {
            switch zikr.loopSize {
            case .infinity:
                EmptyView()
            default:
                Gauge(value: Double(zikr.currentLoopCount), in: 0...Double(zikr.loopSize.rawValue)) {
                    HStack {
                        Text("\(zikr.currentLoopCount)")
                        Spacer()
                        Text("x\(zikr.loopsCount)")
                    }
                    .font(.app.mBody)
                    .foregroundStyle(Color.app.tint)
                    .monospaced()
                    .overlay(alignment: .centerFirstTextBaseline) {
                        Text(zikr.name)
                            .font(.app.mTitle)
                            .foregroundStyle(Color.secondary)
                            .lineLimit(1)
                    }
                }
                .tint(.app.tint)
                .animation(.easeInOut, value: zikr.currentLoopCount)
            }

            HStack {
                Text(String(zikr.count))
                    .animation(.easeInOut, value: zikr.count)
                    .font(.app.lTitle)
                    .foregroundStyle(Color.app.tint)

                Spacer()

                Menu {
                    ForEach(LoopSize.allCases, id: \.self) { loopSize in
                        Button {
                            zikr.loopSize = loopSize
                        } label: {
                            Label {
                                Text(loopSize.title)
                            } icon: {
                                zikr.loopSize == loopSize ? loopSize.selectedIcon : Image("")
                            }
                        }
                    }
                } label: {
                    Text(zikr.loopSize.shortTitle)
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
    HeaderView(zikr: .init(name: "Zikr"))
        .padding()
        .preferredColorScheme(.dark)
}
