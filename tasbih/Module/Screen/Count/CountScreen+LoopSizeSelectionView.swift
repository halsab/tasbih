//
//  CountScreen+LoopSizeSelectionView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct LoopSizeSelectionView: View {
        @Bindable var countService: CountService
        
        var body: some View {
            Menu {
                ForEach(LoopSize.allCases, id: \.self) { selectedLoopSize in
                    MenuButton(loopSize: selectedLoopSize)
                }
            } label: {
                MenuLabel()
            }
        }
        
        @ViewBuilder
        func MenuButton(loopSize selectedLoopSize: LoopSize) -> some View {
            Button {
                withAnimation {
                    countService.loopSize = selectedLoopSize
                }
            } label: {
                Label {
                    Text(selectedLoopSize.title)
                } icon: {
                    countService.loopSize == selectedLoopSize ? Image.app.selection.on : Image.app.selection.off
                }
            }
        }
        
        @ViewBuilder
        func MenuLabel() -> some View {
            Text(countService.loopSize.shortTitle)
                .foregroundStyle(Color.app.tint.primary)
                .font(.app.font(.m, weight: .bold))
                .frame(width: 64, height: 32)
                .background(.ultraThinMaterial)
                .clipShape(.capsule)
        }
    }
}
