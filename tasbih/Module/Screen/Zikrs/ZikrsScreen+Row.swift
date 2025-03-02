//
//  ZikrsScreen+Row.swift
//  tasbih
//
//  Created by Khalil Sabirov on 15.02.2025.
//

import SwiftUI
import Charts

extension ZikrsScreen {
    struct Row: View {
        @Bindable var countService: CountService
        @Bindable var zikr: ZikrModel
        
        var body: some View {
            HStack(spacing: 0) {
                VStack(spacing: 4) {
                    HStack {
                        TextContent()
                            .padding(.leading, 16)
                        
                        Spacer()
                        
                        CountValueView(count: zikr.count)
                    }
                    ChartView()
                        .padding(.leading, 17)
                        .padding(.trailing, 9)
                }
                .padding(.top, 8)
                .padding(.trailing, 8)
                .background(
                    BackgroundView()
                )
                
                IncreaseButton()
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background.secondary)
            .clipShape(.rect(cornerRadius: 8))
        }
        
        @ViewBuilder
        private func TextContent() -> some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(zikr.name)
                    .font(.app.font(.m, weight: .semibold))
                    .foregroundStyle(.primary)
                PeriodView()
            }
        }
        
        @ViewBuilder
        private func IncreaseButton() -> some View {
            Image.app.button.increase
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.shape(.system.secondaryLabel), Color.shape(.app.tint.primary))
                .font(.app.font(.xxl))
                .padding(.horizontal, 8)
                .frame(maxHeight: .infinity)
                .background(Color.system.quaternaryFill)
                .onTapGesture {
                    countService.increment(zikr: zikr)
                }
        }
        
        @ViewBuilder
        private func BackgroundView() -> some View {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        zikr.isSelected ? .app.tint.secondary.opacity(0.6) : .clear,
                        .clear
                    ]
                ),
                startPoint: .leading,
                endPoint: .trailing
            )
            .animation(.easeInOut, value: zikr.isSelected)
        }
        
        @ViewBuilder
        private func PeriodView() -> some View {
            switch zikr.resetPeriod {
            case .infinity:
                EmptyView()
            default:
                Text(zikr.resetPeriod.name.uppercased())
                    .foregroundStyle(.secondary)
                    .font(.app.font(.xs, weight: .regular))
                    .padding(.horizontal , 4)
                    .padding(.vertical , 1)
                    .background(.background.secondary)
                    .clipShape(.rect(cornerRadius: 4))
            }
        }
        
        @ViewBuilder
        private func ChartView() -> some View {
            let data = zikr.lastCounts
            let totalCounts = data.reduce(into: 0) { result, count in result += count.value }
            Chart {
                ForEach(data.indices, id: \.self) { index in
                    BarMark(
                        x: .value("Day", index),
                        y: .value("Distance", data[index].value),
                        width: .fixed(34)
                    )
                    .foregroundStyle(Color.app.tint.primary)
                }
            }
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
            .chartLegend(.hidden)
            .chartBackground { _ in
                Color.clear
            }
            .frame(height: totalCounts == 0 ? 4 : 24)
        }
    }
}

#Preview {
    ZikrsScreen.Row(
        countService: CountService(modelContext: ZikrModel.previewContainer.mainContext),
        zikr: ZikrModel.previewModel
    )
    .safeAreaPadding()
}
