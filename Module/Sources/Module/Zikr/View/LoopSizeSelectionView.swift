//
//  LoopSizeSelectionView.swift
//  Module
//
//  Created by Khalil Sabirov on 28.01.2025.
//

import SwiftUI

struct LoopSizeSelectionView: View {
    @Binding var loopSize: LoopSize
    
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
    private func MenuButton(loopSize selectedLoopSize: LoopSize) -> some View {
        Button {
            withAnimation {
                loopSize = selectedLoopSize
            }
        } label: {
            Label {
                Text(selectedLoopSize.title)
            } icon: {
                loopSize == selectedLoopSize ? Image.app.selection.on : Image.app.selection.off
            }
        }
    }
    
    @ViewBuilder
    private func MenuLabel() -> some View {
        Text(loopSize.shortTitle)
            .foregroundStyle(Color.app.tint)
            .font(.app.font(.m, .bold))
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(.ultraThinMaterial)
            .clipShape(.capsule)
    }
}

//#Preview {
//    LoopSizeSelectionView()
//}
