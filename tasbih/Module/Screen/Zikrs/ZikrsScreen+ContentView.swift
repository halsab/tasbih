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
        
        private var isNewZikrNameInvalid: Bool {
            newZikrName.isEmpty || countService.isZikrExist(withName: newZikrName)
        }
        
        var body: some View {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(countService.zikrs) { zikr in
                        RowView(zikr: zikr)
                    }
                }
                .safeAreaPadding()
            }
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
                TextField(String.text.textField.placeholder.zikrName, text: $newZikrName)
                Button(String.text.button.create) {
                    countService.createZikr(name: newZikrName)
                    newZikrName = ""
                }
                .disabled(isNewZikrNameInvalid)
                Button(String.text.button.cancel, role: .cancel) {
                    newZikrName = ""
                }
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
    }
}

#Preview {
    NavigationStack {
        ZikrsScreen.ContentView(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
    }
}
