//
//  CountScreen+ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
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
            .tint(.app.tint.primary)
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
