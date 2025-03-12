//
//  CountScreen+FooterView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct FooterView: View {
        @Bindable var countService: CountService
        
        @State private var showResetAlert = false
        
        private let textButtonWidth: CGFloat = 80
        
        var body: some View {
            if let zikr = countService.selectedZikr {
                HStack {
                    TextButtonView(text: .text.button.reset.uppercased(), alignment: .leading) {
                        countService.hapticFeedback()
                        showResetAlert.toggle()
                    }
                    .frame(width: textButtonWidth)
                    
                    Spacer()
                    
                    Button {
                        countService.showZikrsSheet.toggle()
                    } label: {
                        Image.app.icon.list
                            .font(.title)
                            .foregroundStyle(Color.shape(.app.tint.primary))
                    }
                    
                    Spacer()
                    
                    TextButtonView(text: .text.button.undo.uppercased(), alignment: .trailing) {
                        countService.decrement(zikr: zikr)
                    }
                    .frame(width: textButtonWidth)
                }
                .alert(String.text.alert.resetZikrCompletely, isPresented: $showResetAlert) {
                    Button(String.text.button.yes, role: .destructive) {
                        countService.reset(zikr: zikr)
                    }
                    Button(String.text.button.no, role: .cancel) {}
                }
            } else {
                EmptyView()
            }
        }
    }
}
