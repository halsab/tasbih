//
//  ZikrsScreen+Row.swift
//  tasbih
//
//  Created by Khalil Sabirov on 15.02.2025.
//

import SwiftUI

extension ZikrsScreen {
    struct Row: View {
        @Bindable var countService: CountService
        @Bindable var zikr: ZikrModel
        
        var body: some View {
            HStack(spacing: 0) {
                HStack {
                    TextContent()
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    CountValueView(count: zikr.count)
                }
                .padding(.vertical, 8)
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
            VStack(alignment: .leading, spacing: 6) {
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
            HStack {
                Text(zikr.resetPeriod.rawValue.uppercased())
                    .font(.app.font(.xs, weight: .semibold))
                    .padding(.horizontal , 6)
                    .padding(.vertical , 2)
                    .background(Color.app.tint.secondary.opacity(0.6))
                    .clipShape(.rect(cornerRadius: 4))
                
                let date = Date.now
                let dateText: String = switch zikr.resetPeriod {
                case .day: String(date.dayNumber)
                case .week: String(date.weekNumber)
                case .month: date.monthName
                case .year: String(date.yearNumber)
                case .infinity: ""
                }
                
                Text(dateText)
                    .font(.app.font(.s, weight: .semibold))
            }
            .foregroundStyle(.primary)
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
