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
                MainStateHeaderView(viewModel: viewModel)
                //                    MainStateCentralView()
                //                    MainStateFooterView()
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

private extension CountScreen {
    struct MainStateHeaderView: View {
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
