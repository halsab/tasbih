//
//  NewZikrCreationView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 23.02.2025.
//

import SwiftUI

struct NewZikrCreationView: View {
    @Bindable var countService: CountService
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var resetPeriod: ResetPeriod = .day
    @FocusState private var focusedField: FocusedField?
    
    enum FocusedField {
        case zikrName
    }
    
    var body: some View {
        Form {
            Section {
                TextField(String.text.zikrCreation.nameSection.placeholder, text: $name)
                    .focused($focusedField, equals: .zikrName)
                    .tint(Color.app.tint.primary)
            } header: {
                Text(String.text.zikrCreation.nameSection.header)
            } footer: {
                Text(String.text.zikrCreation.nameSection.footer)
            }
            
            Section {
                Picker(String.text.zikrCreation.periodSection.title, selection: $resetPeriod) {
                    ForEach(ResetPeriod.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
            } footer: {
                Text(String.text.zikrCreation.periodSection.footer)
            }
        }
        .safeAreaInset(edge: .bottom) {
            TextButtonView(text: String.text.button.create.uppercased()) {
                countService.createZikr(name: name, resetPeriod: resetPeriod)
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
        NewZikrCreationView(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
    }
}
