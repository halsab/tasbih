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
    @State private var showFirstZikrCreationAlert = false
    @State private var firstZikrName = ""
    
    public var body: some View {
        ContentView()
            .alert(String.text.alert.createFirstZikr, isPresented: $showFirstZikrCreationAlert) {
                FirstZikrCreationAlert()
            }
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
    @ViewBuilder
    func ContentView() -> some View {
        switch viewModel.contentState {
        case .empty: EmptyStateView()
        case .main: MainStateView()
        }
    }
    
    @ViewBuilder
    func EmptyStateView() -> some View {
        Button {
            showFirstZikrCreationAlert.toggle()
        } label: {
            Label {
                Text(String.text.button.createFirstZikr)
            } icon: {
                Image.app.icon.plus
            }
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.extraLarge)
    }
    
    @ViewBuilder
    func MainStateView() -> some View {
        Text("main")
    }
}

// MARK: - FirstZikrCreationAlert

private extension CountScreen {
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
