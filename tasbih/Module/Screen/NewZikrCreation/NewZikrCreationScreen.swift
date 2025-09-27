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
        self.name = name
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        Form {
            Section {
                Picker(String.text.zikrCreation.periodSection.title, selection: $resetPeriod) {
                    ForEach(ResetPeriod.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
            } footer: {
                Text(String.text.zikrCreation.periodSection.footer)
            }
            
            Section {
                TextField(String.text.zikrCreation.nameSection.placeholder, text: $name)
                    .focused($focusedField, equals: .zikrName)
            } footer: {
                Text(String.text.zikrCreation.nameSection.footer)
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
