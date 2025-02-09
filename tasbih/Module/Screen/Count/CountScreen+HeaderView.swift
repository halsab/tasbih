//
//  CountScreen+HeaderView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct HeaderView: View {
        @Bindable var viewModel: ViewModel
        
        var body: some View {
            if let zikr = viewModel.selectedZikr {
                switch viewModel.headerState {
                case .compact: CompactMainStateHeaderView(viewModel: viewModel, zikr: zikr)
                case .full: FullMainStateHeaderView(viewModel: viewModel, zikr: zikr)
                }
            } else {
                EmptyView()
            }
        }
        
        struct CompactMainStateHeaderView: View {
            @Bindable var viewModel: ViewModel
            @Bindable var zikr: ZikrModel
            
            var body: some View {
                VStack(spacing: 6) {
                    HStack {
                        CountValueView(count: zikr.count)
                        Spacer()
                        LoopSizeSelectionView(viewModel: viewModel)
                    }
                    ZikrNameView(name: zikr.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        
        struct FullMainStateHeaderView: View {
            @Bindable var viewModel: ViewModel
            @Bindable var zikr: ZikrModel
            
            var body: some View {
                VStack(spacing: 6) {
                    CountProgress()
                    
                    HStack {
                        CountValueView(count: zikr.count)
                        Spacer()
                        LoopSizeSelectionView(viewModel: viewModel)
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
                            .contentTransition(.numericText())
                        Spacer()
                        Text("x\(zikr.loopsCount)")
                            .contentTransition(.numericText())
                    }
                    .font(.app.font(.m))
                    .foregroundStyle(Color.app.tint.primary)
                    .monospaced()
                    .overlay(alignment: .centerFirstTextBaseline) {
                        ZikrNameView(name: zikr.name)
                    }
                }
                .tint(.app.tint.primary)
                .animation(.easeInOut, value: zikr.currentLoopCount)
            }
        }
    }
}
