//
//  FooterView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 26.03.2024.
//

import SwiftUI
import AppUIKit

struct FooterView: View {

    @Bindable var zikr: ZikrModel
    @Environment(\.modelContext) private var modelContext
    @AppStorage(.storageKey.common.haptic) var isHapticEnabled = false
    @State private var showZikrs = false
    @State private var showZikrResettingAlert = false
    
    private let bounceAnimationSpeed: Double = 1.3

    var body: some View {
        HStack {
            Button {} label: {
                Text(String.text.button.reset)
            }
            .padding()
            .buttonStyle(CustomButtonStyle())
            .simultaneousGesture(
                LongPressGesture()
                    .onEnded { _ in
                        showZikrResettingAlert.toggle()
                    }
            )
            .highPriorityGesture(
                TapGesture()
                    .onEnded {
                        resetLoop()
                    }
            )
            
            Spacer()
            
            Button {
                isHapticEnabled.toggle()
            } label: {
                (isHapticEnabled ? Image.app.haptic.on : Image.app.haptic.off)
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.shape(.app.tint))
                
            }
            .padding(8)
            .symbolEffect(.bounce.down, options: .speed(bounceAnimationSpeed), value: isHapticEnabled)
            .contentTransition(.symbolEffect(.replace))
            
            Button {
                showZikrs.toggle()
            } label: {
                Image.app.icon.list
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.shape(.app.tint))
                
            }
            .padding(8)
            .scaleEffect(showZikrs ? 0.8 : 1.0)
            
            Spacer()
            
            Button {
                undo()
            } label: {
                Text(String.text.button.undo)
            }
            .padding()
            .buttonStyle(CustomButtonStyle())
        }
        .sheet(isPresented: $showZikrs) {
            ZikrsView()
                .presentationDetents([.large])
        }
        .alert("Reset this zikr completely?", isPresented: $showZikrResettingAlert) {
            Button("Reset", role: .destructive, action: resetAll)
            Button("Cancel", role: .cancel) {}
        }
    }
    
    private func resetLoop() {
        zikr.count = zikr.loopsCount * zikr.loopSize.rawValue
        try? modelContext.save()
    }
    
    private func resetAll() {
        zikr.count = 0
        try? modelContext.save()
    }
    
    private func undo() {
        if zikr.count > 0 {
            zikr.count -= 1
            try? modelContext.save()
        }
    }
}

#Preview {
    FooterView(zikr: .init(name: "Zikr"))
        .padding()
        .preferredColorScheme(.dark)
}
