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
                    Menu {
                        NavigationLink(destination: NamazScreen()) {
                            Text(String.text.button.namaz)
                        }
                        NavigationLink(destination: HajjScreen()) {
                            Text(String.text.button.hadj)
                        }
                    } label: {
                        Image.app.icon.more
                            .font(.title)
                            .foregroundStyle(Color.shape(.app.tint.primary))
                    }
                    .frame(width: textButtonWidth, alignment: .leading)
                    
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
                    } longPressAction: {
                        countService.hapticFeedback()
                        showResetAlert.toggle()
                    }
                    .frame(width: textButtonWidth)
                    .popoverTip(UndoTip()) // TODO: update tip to say about long tap
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
