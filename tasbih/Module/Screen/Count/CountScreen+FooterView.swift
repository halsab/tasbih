//
//  CountScreen+FooterView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct FooterView: View {
        @Bindable var viewModel: ViewModel
        
        @State private var showResetAlert = false
        
        var body: some View {
            if let zikr = viewModel.selectedZikr {
                HStack {
                    TextButtonView(text: .text.button.reset.uppercased()) {
                        showResetAlert.toggle()
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.showZikrsSheet.toggle()
                    } label: {
                        Image.app.icon.list
                            .font(.title)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color.shape(.app.tint.primary))
                    }
                    
                    Spacer()
                    
                    TextButtonView(text: .text.button.undo.uppercased()) {
                        viewModel.decrement(zikr: zikr)
                    }
                }
                .alert(String.text.alert.resetZikrCompletely, isPresented: $showResetAlert) {
                    Button(String.text.button.yes, role: .destructive) {
                        viewModel.reset(zikr: zikr)
                    }
                    Button(String.text.button.no, role: .cancel) {}
                }
            } else {
                EmptyView()
            }
        }
    }
}
