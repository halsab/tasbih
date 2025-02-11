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
                        Row(zikr: $0)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
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
        private func Row(zikr: ZikrModel) -> some View {
            HStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(zikr.name)
                            .font(.app.font(.m, weight: .semibold))
                            .foregroundStyle(.primary)
                        Text(zikr.date.formatted(date: .numeric, time: .shortened))
                            .font(.app.font(.s))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    CountScreen.CountValueView(count: zikr.count)
                }
                .padding(.vertical, 8)
                
                Image(systemName: "plus.circle")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.shape(.white), Color.shape(.app.tint.primary))
                    .font(.app.font(.xxl))
                    .padding(.horizontal, 8)
                    .frame(maxHeight: .infinity)
                    .background(.background.secondary)
                    .onTapGesture {
                        countService.increment(zikr: zikr)
                    }
                
            }
            .fixedSize(horizontal: false, vertical: true)
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
