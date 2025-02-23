//
//  ZikrsScreen+ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension ZikrsScreen {
    struct ContentView: View {
        @Bindable var countService: CountService
        @Environment(\.dismiss) var dismiss
        
        @State private var showZikrCreationAlert = false
        @State private var newZikrName = ""
        
        var body: some View {
            List {
                Section {
                    HeaderSection()
                }
                Section {
                    ZikrsSection()
                }
            }
            .listStyle(.plain)
            .listRowSpacing(0)
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                BottomToolbar()
            }
            .alert(String.text.alert.createNewZikr, isPresented: $showZikrCreationAlert) {
                ZikrCreationAlertView(name: $newZikrName, isValid: {
                    countService.isNewZikrNameValid(newZikrName)
                }, action: {
                    countService.createZikr(name: newZikrName)
                })
            }
        }
        
        @ViewBuilder
        private func HeaderSection() -> some View {
            InfoHeaderView(
                image: Image.app.infoHeader.zikrs,
                title: String.text.title.zikrs,
                description: String.text.info.zikrsHeader
            )
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
        
        @ViewBuilder
        private func ZikrsSection() -> some View {
            ForEach(countService.zikrs) { zikr in
                Row(countService: countService, zikr: zikr)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            countService.deleteZikr(zikr: zikr)
                        } label: {
                            Image.app.swipe.delete
                        }
                        .tint(.clear)
                    }
                    .onTapGesture {
                        countService.select(zikr: zikr)
                        dismiss()
                    }
            }
        }
        
        @ViewBuilder
        private func BottomToolbar() -> some View {
            Button {
                countService.hapticFeedback()
                showZikrCreationAlert.toggle()
            } label: {
                Image.app.button.create
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.shape(.white), Color.shape(.app.tint.primary))
                    .bold()
                    .shadow(color: .primary.opacity(0.4), radius: 10, x: 0, y: 0)
            }
            .frame(height: 64)
            .padding(.vertical)
        }
    }
}

#Preview {
    NavigationStack {
        ZikrsScreen.ContentView(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
    }
}
