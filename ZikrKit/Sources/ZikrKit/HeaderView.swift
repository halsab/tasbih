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
                Gauge(
                    value: Double(zikr.currentLoopCount),
                    in: 0...Double(zikr.loopSize.rawValue)
                ) {
                    HStack {
                        Text("\(zikr.currentLoopCount)")
                            .contentTransition(.numericText())
                        Spacer()
                        Text("x\(zikr.loopsCount)")
                    }
                    .font(.app.font(.m))
                    .foregroundStyle(Color.app.tint)
                    .monospaced()
                    .overlay(alignment: .centerFirstTextBaseline) {
                        zikrNameView(zikr)
                    }
                }
                .tint(.app.tint)
                .animation(.easeInOut, value: zikr.currentLoopCount)
            }

            HStack {
                Text(String(zikr.count))
                    .contentTransition(.numericText())
                    .font(.app.font(.xxxl, .bold))
                    .foregroundStyle(Color.app.tint)

                Spacer()
                
                Menu {
                    ForEach(LoopSize.allCases, id: \.self) { loopSize in
                        Button {
                            withAnimation {
                                zikr.loopSize = loopSize
                            }
                        } label: {
                            Label {
                                Text(loopSize.title)
                            } icon: {
                                zikr.loopSize == loopSize ? Image.app.selection.on : Image.app.selection.off
                            }
                        }
                    }
                } label: {
                    Text(zikr.loopSize.shortTitle)
                        .foregroundStyle(Color.app.tint)
                        .font(.app.font(.m, .bold))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(.ultraThinMaterial)
                        .clipShape(.capsule)
                }
            }
            
            if zikr.loopSize == .infinity {
                zikrNameView(zikr)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    @ViewBuilder
    private func zikrNameView(_ zikr: ZikrModel) -> some View {
        Text(zikr.name)
            .font(.app.font(.m, .bold))
            .foregroundStyle(Color.secondary)
            .lineLimit(1)
    }
}

#Preview {
    HeaderView(zikr: .init(name: "Zikr"))
        .padding()
        .preferredColorScheme(.dark)
}
