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
            VStack(spacing: 12) {
                HStack {
                    TextContent()
                    
                    Spacer()
                    
                    CountValueView(count: zikr.count)
                }
                
                if isAnyZikrOnLastDays {
                    StatView()
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 12)
            .background(
                BackgroundView()
            )
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background.secondary)
            .clipShape(.rect(cornerRadius: 8))
        }
        
        private var isAnyZikrOnLastDays: Bool {
            zikr.lastCounts.map(\.value).max() ?? 0 > 0
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
        private func StatView() -> some View {
            // Подготовка данных
            let values: [Double] = zikr.lastCounts.map { Double($0.value) }
            
            // X-домен: для одной точки даем диапазон 0...1, чтобы был видимый график
            let xUpper = Double(max(values.count - 1, 1))
            
            // Y-домен с паддингом
            let minY = values.min() ?? 0
            let maxY = values.max() ?? 0
            let span = max(maxY - minY, 0)
            // Небольшой запас, чтобы подписи не упирались в край
            let padYInDomain = max(1.0, span) * 0.15 + 6
            let paddedMin = minY - padYInDomain
            let paddedMax = maxY + padYInDomain
            
            // Равномерный внутренний отступ сверху/снизу в области графика
            let yPlotPadding: CGFloat = 10
            
            // Динамическая высота графика от разброса значений
            // expectedSpanForMaxHeight — при таком разбросе высота достигнет maxChartHeight
            let minChartHeight: CGFloat = 24
            let maxChartHeight: CGFloat = 64
            let expectedSpanForMaxHeight: CGFloat = 50
            let normalized = min(max(CGFloat(span) / expectedSpanForMaxHeight, 0), 1)
            let chartHeight: CGFloat = minChartHeight + (maxChartHeight - minChartHeight) * normalized
            
            Chart {
                // Линия + точки + аннотации значений
                ForEach(values.indices, id: \.self) { i in
                    let current = values[i]
                    let slope: Double = {
                        if i < values.count - 1 { return values[i + 1] - current }
                        else if i > 0 { return current - values[i - 1] }
                        else { return 0 }
                    }()
                    
                    let horizontalAlignment: Alignment = {
                        if i == 0 { return .leading }
                        if i == values.count - 1 { return .trailing }
                        return .center
                    }()
                    
                    LineMark(
                        x: .value("Day", i),
                        y: .value("Value", current)
                    )
                    .interpolationMethod(.cardinal)
                    .lineStyle(.init(lineWidth: 2, lineCap: .round))
                    .foregroundStyle(Color.shape(.app.tint.secondary))
                    .zIndex(1)
                    
                    PointMark(
                        x: .value("Day", i),
                        y: .value("Value", current)
                    )
                    .symbol(.circle)
                    .symbolSize(30)
                    .foregroundStyle(Color.shape(.app.tint.secondary))
                    .zIndex(2)
                    .annotation(
                        position: slope >= 0 ? .top : .bottom,
                        alignment: horizontalAlignment
                    ) {
                        Text("\(Int(current))")
                            .font(.app.font(.xs))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .chartLegend(.hidden)
            .chartXScale(
                domain: 0...xUpper,
                range: .plotDimension(padding: 4)
            )
            .chartYScale(
                domain: paddedMin...paddedMax,
                range: .plotDimension(padding: yPlotPadding)
            )
            .chartPlotStyle { plot in
                plot.background(.clear)
            }
            .frame(height: chartHeight) // динамическая высота вместо фиксированной
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
