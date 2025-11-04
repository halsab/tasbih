//
//  NewZikrCreationScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 23.02.2025.
//

import SwiftUI

struct NewZikrCreationScreen: View {
    @Bindable var countService: CountService
    let onDismiss: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var resetPeriod: ResetPeriod = .day
    @FocusState private var focusedField: FocusedField?
    
    enum FocusedField {
        case zikrName
    }
    
    init(
        countService: CountService,
        name: String = "",
        onDismiss: @escaping () -> Void
    ) {
        self.countService = countService
        self._name = .init(initialValue: name)
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        Form {
            Section {
                TextField(String.text.zikrCreation.nameSection.placeholder, text: $name)
                    .focused($focusedField, equals: .zikrName)
            } header: {
                Text(String.text.zikrCreation.nameSection.header)
            } footer: {
                Text(String.text.zikrCreation.nameSection.footer)
            }
            
            Section {
                Picker(String.text.zikrCreation.periodSection.header, selection: $resetPeriod) {
                    ForEach(ResetPeriod.allCases, id: \.self) {
                        Text($0.period)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text(String.text.zikrCreation.periodSection.header)
            } footer: {
                Text(String.text.zikrCreation.periodSection.footer)
            }
        }
        .tint(Color.app.tint.primary)
        .safeAreaInset(edge: .bottom) {
            TextButtonView(text: String.text.button.create.uppercased()) {
                countService.createZikr(name: name, resetPeriod: resetPeriod)
                onDismiss()
                dismiss()
            }
            .disabled(!countService.isNewZikrNameValid(name))
            .safeAreaPadding()
        }
        .navigationTitle(String.text.zikrCreation.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            focusedField = .zikrName
        }
    }
}

#Preview {
    NavigationStack {
        NewZikrCreationScreen(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext)) {}
    }
}
