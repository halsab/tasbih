//
//  ZikrScreen.swift
//  Module
//
//  Created by Khalil Sabirov on 28.01.2025.
//

import SwiftUI
import ViewUI

struct ZikrScreen: View {
    
    @State private var count: Int = 0
    @State private var loopSize: LoopSize = .infinity
    @State private var currentLoopCount = 0
    @State private var loopsCount = 0
    @State private var zikrName = "ZikrName"
    
    var body: some View {
        Content(
            currentLoopCount: currentLoopCount,
            loopsCount: loopsCount,
            zikrName: zikrName,
            count: $count,
            loopSize: $loopSize,
            countAction: {},
            undoAction: {},
            resetAction: {},
            resetAllAction: {},
            showZikrsAction: {}
        )
        .safeAreaPadding()
    }
}

#Preview {
    NavigationStack {
        ZikrScreen()
    }
}

private struct Content: View {
    
    let currentLoopCount: Int
    let loopsCount: Int
    let zikrName: String
    @Binding var count: Int
    @Binding var loopSize: LoopSize
    let countAction: () -> Void
    let undoAction: () -> Void
    let resetAction: () -> Void
    let resetAllAction: () -> Void
    let showZikrsAction: () -> Void
    
    var body: some View {
        VStack {
            Header(
                count: count,
                currentLoopCount: currentLoopCount,
                loopsCount: loopsCount,
                zikrName: zikrName,
                loopSize: $loopSize
            )
            Central(
                count: $count,
                action: countAction
            )
            Footer(
                undoAction: undoAction,
                resetPrimaryAction: resetAction,
                resetSecondaryAction: resetAllAction,
                sheetAction: showZikrsAction
            )
        }
    }
}

private struct Header: View {
    
    private enum ViewState {
        case compact, full
    }
    
    let count: Int
    let currentLoopCount: Int
    let loopsCount: Int
    let zikrName: String
    @Binding var loopSize: LoopSize
    
    @State private var viewState: ViewState = .compact
    
    var body: some View {
        Group {
            switch viewState {
            case .compact:
                HeaderCompact(
                    count: count,
                    zikrName: zikrName,
                    loopSize: $loopSize
                )
            case .full:
                HeaderFull(
                    count: count,
                    currentLoopCount: currentLoopCount,
                    loopsCount: loopsCount,
                    zikrName: zikrName,
                    loopSize: $loopSize
                )
            }
        }
        .onChange(of: loopSize) {
            viewState = switch loopSize {
            case .infinity: .compact
            default: .full
            }
        }
    }
}

private struct Central: View {
    @Binding var count: Int
    let action: () -> Void
    
    @State private var tapTrigger = false
    
    var body: some View {
        ZStack {
            CentralAnimation(animationTrigger: $tapTrigger)
            CentralImage(value: count)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            action()
            tapTrigger.toggle()
        }
    }
}

private struct Footer: View {
    let undoAction: () -> Void
    let resetPrimaryAction: () -> Void
    let resetSecondaryAction: () -> Void
    let sheetAction: () -> Void
    
    @State private var showResetAllAlert = false
    
    var body: some View {
        HStack {
            ResetButton(action: resetPrimaryAction)
            Spacer()
            SheetButton(action: sheetAction)
            Spacer()
            UndoButton(action: undoAction)
        }
        .alert(String.text.alert.resetZikrCompletely, isPresented: $showResetAllAlert) {
            Button(String.text.button.reset, role: .destructive, action: resetSecondaryAction)
            Button(String.text.button.cancel, role: .cancel) {}
        }
    }
    
    @ViewBuilder
    private func ResetButton(action: @escaping () -> Void) -> some View {
        Button(action: {}) {
            Text(String.text.button.reset.uppercased())
        }
        .buttonStyle(TextButtonStyle())
        .simultaneousGesture(
            LongPressGesture()
                .onEnded { _ in
                    showResetAllAlert.toggle()
                }
        )
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    action()
                }
        )
    }
    
    @ViewBuilder
    private func UndoButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(String.text.button.undo.uppercased())
        }
        .buttonStyle(TextButtonStyle())
    }
    
    @ViewBuilder
    private func SheetButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image.app.icon.list
                .font(.title)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.shape(.app.tint))
            
        }
    }
}

private struct HeaderCompact: View {
    let count: Int
    let zikrName: String
    @Binding var loopSize: LoopSize
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                CountValueView(count: count)
                Spacer()
                LoopSizeSelectionView(loopSize: $loopSize)
            }
            ZikrNameView(name: zikrName)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct HeaderFull: View {
    let count: Int
    let currentLoopCount: Int
    let loopsCount: Int
    let zikrName: String
    @Binding var loopSize: LoopSize
    
    var body: some View {
        VStack(spacing: 6) {
            CountProgressView(
                currentLoopCount: currentLoopCount,
                loopsCount: loopsCount,
                zikrName: zikrName,
                loopSize: loopSize
            )
            
            HStack {
                CountValueView(count: count)
                Spacer()
                LoopSizeSelectionView(loopSize: $loopSize)
            }
        }
    }
}

private struct CentralImage<U: Equatable>: View {
    let value: U
    var body: some View {
        Image.app.button.count
            .font(.system(size: 100))
            .foregroundStyle(Color.shape(.app.tint))
            .symbolEffect(.bounce, options: .nonRepeating.speed(2), value: value)
    }
}

private struct CentralAnimation: View {
    @Binding var animationTrigger: Bool
    
    @State private var pulsedHearts: [HeartParticleModel] = []
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.5, paused: false)) { _ in
            Canvas { context, size in
                handleCanvas(context: context, size: size)
            } symbols: {
                CanvasSymbols()
            }
        }
        .blur(radius: 15)
        .onChange(of: animationTrigger) {
            addPulsedHeart()
        }
    }
    
    @ViewBuilder
    private func CanvasSymbols() -> some View {
        ForEach(pulsedHearts) {
            PulsedHeartView()
                .id($0.id)
        }
    }
    
    private func handleCanvas(context: GraphicsContext, size: CGSize) {
        pulsedHearts
            .compactMap { context.resolveSymbol(id: $0.id) }
            .forEach { context.draw($0, at: .init(x: size.width / 2, y: size.height / 2)) }
    }
    
    private func addPulsedHeart() {
        let pulsedHeart = HeartParticleModel()
        pulsedHearts.append(pulsedHeart)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            pulsedHearts.removeAll(where: { $0.id == pulsedHeart.id })
        }
    }
}
