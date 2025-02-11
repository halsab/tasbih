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
        
        @State private var showZikrCreationAlert = false
        @State private var newZikrName = ""
        
        var body: some View {
            List(countService.zikrs) {
                Row(title: $0.name, subtitle: $0.date.formatted(date: .numeric, time: .shortened))
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
                    .safeAreaPadding(.horizontal)
            }
            .listStyle(.plain)
            .listRowSpacing(0)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    BottomToolbar()
                }
                ToolbarItem(placement: .principal) {
                    TopToolbar()
                }
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
        private func TopToolbar() -> some View {
            Text(String.text.title.zikrs)
                .font(.app.font(.m, .bold))
        }
        
        @ViewBuilder
        private func BottomToolbar() -> some View {
            Spacer()
            
            TextButtonView(text: String.text.button.create.uppercased()) {
                showZikrCreationAlert.toggle()
            }
        }
        
        @ViewBuilder
        private func Row(
            title: String,
            subtitle: String
        ) -> some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.app.font(.m, .semibold))
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.app.font(.s, .regular))
                    .foregroundStyle(.secondary)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.tertiary)
            .clipShape(.rect(cornerRadius: 8))
        }
    }
}

#Preview {
    NavigationStack {
        ZikrsScreen.ContentView(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
    }
}
