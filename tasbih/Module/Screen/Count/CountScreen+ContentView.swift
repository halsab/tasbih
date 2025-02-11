//
//  CountScreen+ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct ContentView: View {
        @Bindable var countService: CountService
        
        @State private var showFirstZikrCreationAlert = false
        @State private var firstZikrName = ""
        
        var body: some View {
            switch countService.contentState {
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
                ZikrCreationAlertView(name: $firstZikrName, isValid: {
                    countService.isNewZikrNameValid(firstZikrName)
                }, action: {
                    countService.createZikr(name: firstZikrName)
                })
            }
        }
        
        @ViewBuilder
        func MainState() -> some View {
            VStack {
                HeaderView(countService: countService)
                CentralView(countService: countService)
                FooterView(countService: countService)
            }
        }
    }
}
