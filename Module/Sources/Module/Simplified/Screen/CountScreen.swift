//
//  CountScreen.swift
//  Module
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI
import SwiftData
import Helper

public struct CountScreen: View {
    @State private var viewModel: ViewModel
    
    public var body: some View {
        ContentView(viewModel: viewModel)
            .safeAreaPadding()
    }
    
    public init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

#Preview {
    CountScreen(modelContext: ZikrModel.previewContainer.mainContext)
}

// MARK: - ContentView

private extension CountScreen {
    struct ContentView: View {
        @Bindable var viewModel: ViewModel
        
        @State private var showFirstZikrCreationAlert = false
        @State private var firstZikrName = ""
        
        var body: some View {
            switch viewModel.contentState {
            case .empty: EmptyState()
            case .main: MainState()
            }
        }
        
        @ViewBuilder
        func EmptyState() -> some View {
            Button {
                showFirstZikrCreationAlert.toggle()
            } label: {
                Label {
                    Text(String.text.button.createFirstZikr)
                } icon: {
                    Image.app.icon.plus
                }
                .font(.app.font(.m, .semibold))
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.extraLarge)
            .tint(.app.tint)
            .alert(String.text.alert.createFirstZikr, isPresented: $showFirstZikrCreationAlert) {
                FirstZikrCreationAlert()
            }
        }
        
        @ViewBuilder
        func MainState() -> some View {
            VStack {
                HeaderView(viewModel: viewModel)
                CentralView(viewModel: viewModel)
                FooterView(viewModel: viewModel)
            }
        }
        
        @ViewBuilder
        func FirstZikrCreationAlert() -> some View {
            TextField(String.text.textField.placeholder.zikrName, text: $firstZikrName)
            Button(String.text.button.create) {
                viewModel.createZikr(name: firstZikrName)
                firstZikrName = ""
            }
            Button(String.text.button.cancel, role: .cancel) {
                firstZikrName = ""
            }
        }
    }
}

// MARK: - HeaderView

private extension CountScreen {
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
                    }
                    .font(.app.font(.m))
                    .foregroundStyle(Color.app.tint)
                    .monospaced()
                    .overlay(alignment: .centerFirstTextBaseline) {
                        ZikrNameView(name: zikr.name)
                    }
                }
                .tint(.app.tint)
                .animation(.easeInOut, value: zikr.currentLoopCount)
            }
        }
    }
}

// MARK: - LoopSizeSelection

private extension CountScreen {
    struct LoopSizeSelectionView: View {
        @Bindable var viewModel: ViewModel
        
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
                    viewModel.loopSize = selectedLoopSize
                }
            } label: {
                Label {
                    Text(selectedLoopSize.title)
                } icon: {
                    viewModel.loopSize == selectedLoopSize ? Image.app.selection.on : Image.app.selection.off
                }
            }
        }
        
        @ViewBuilder
        func MenuLabel() -> some View {
            Text(viewModel.loopSize.shortTitle)
                .foregroundStyle(Color.app.tint)
                .font(.app.font(.m, .bold))
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(.ultraThinMaterial)
                .clipShape(.capsule)
        }
    }
}

// MARK: - ZikrName

private extension CountScreen {
    struct ZikrNameView: View {
        let name: String
        
        var body: some View {
            Text(name)
                .font(.app.font(.m, .bold))
                .foregroundStyle(Color.secondary)
                .lineLimit(1)
        }
    }
}

// MARK: - CountValue

private extension CountScreen {
    struct CountValueView: View {
        let count: Int
        
        var body: some View {
            Text(String(count))
                .contentTransition(.numericText())
                .font(.app.font(.xxxl, .bold))
                .foregroundStyle(Color.app.tint)
        }
    }
}

// MARK: - CentralView

private extension CountScreen {
    private struct CentralView: View {
        @Bindable var viewModel: ViewModel
        
        var body: some View {
            if let zikr = viewModel.selectedZikr {
                ZStack {
                    AnimationView(zikr: zikr)
                    
                    Image.app.button.count
                        .font(.system(size: 100))
                        .foregroundStyle(Color.shape(.app.tint))
                        .symbolEffect(.bounce, options: .nonRepeating.speed(2), value: zikr.count)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    zikr.count += 1
                }
            } else {
                EmptyView()
            }
        }
        
        struct AnimationView: View {
            @Bindable var zikr: ZikrModel
            
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
                .onChange(of: zikr.count) {
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
    }
}

// MARK: - FooterView

private extension CountScreen {
    struct FooterView: View {
        @Bindable var viewModel: ViewModel
        
        var body: some View {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}
