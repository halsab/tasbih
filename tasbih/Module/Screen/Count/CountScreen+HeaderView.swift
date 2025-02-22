//
//  CountScreen+HeaderView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct HeaderView: View {
        @Bindable var countService: CountService
        
        var body: some View {
            if let zikr = countService.selectedZikr {
                switch countService.headerState {
                case .compact: CompactHeaderView(countService: countService, zikr: zikr)
                case .full: FullHeaderView(countService: countService, zikr: zikr)
                }
            } else {
                EmptyView()
            }
        }
        
        struct CompactHeaderView: View {
            @Bindable var countService: CountService
            @Bindable var zikr: ZikrModel
            
            var body: some View {
                VStack(spacing: 6) {
                    HStack {
                        CountValueView(count: zikr.count)
                        Spacer()
                        LoopSizeSelectionView(countService: countService)
                    }
                    ZikrNameView(name: zikr.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        
        struct FullHeaderView: View {
            @Bindable var countService: CountService
            @Bindable var zikr: ZikrModel
            
            var body: some View {
                VStack(spacing: 6) {
                    CountProgress()
                    
                    HStack {
                        CountValueView(count: zikr.count)
                        Spacer()
                        LoopSizeSelectionView(countService: countService)
                    }
                }
            }
            
            @ViewBuilder
            private func CountProgress() -> some View {
                Gauge(
                    value: Double(zikr.currentLoopCount),
                    in: 0...Double(zikr.loopSize.rawValue)
                ) {
                    HStack {
                        Text("\(zikr.currentLoopCount)")
                            .monospaced()
                        Spacer()
                        ZikrNameView(name: zikr.name)
                        Spacer()
                        Text("x\(zikr.loopsCount)")
                            .monospaced()
                    }
                    .contentTransition(.numericText())
                    .font(.app.font(.m))
                    .foregroundStyle(Color.secondary)
                }
                .tint(.app.tint.primary)
                .animation(.easeInOut, value: zikr.currentLoopCount)
            }
        }
    }
}
