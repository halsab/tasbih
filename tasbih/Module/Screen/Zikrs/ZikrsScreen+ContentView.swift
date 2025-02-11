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
            List {
                Section {
                    InfoHeaderView(
                        image: Image(systemName: "heart.square.fill"),
                        title: String.text.title.zikrs,
                        description: String.text.info.zikrsHeader
                    )
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
                }
                Section {
                    ForEach(countService.zikrs) {
                        Row(title: $0.name, subtitle: $0.date.formatted(date: .numeric, time: .shortened))
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                    }
                }
            }
            .listStyle(.plain)
            .listRowSpacing(0)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    BottomToolbar()
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
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.app.font(.m, weight: .semibold))
                        .foregroundStyle(.primary)
                    Text(subtitle)
                        .font(.app.font(.s))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background.tertiary)
            .clipShape(.rect(cornerRadius: 8))
        }
    }
}

#Preview {
    NavigationStack {
        ZikrsScreen.ContentView(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
    }
}
