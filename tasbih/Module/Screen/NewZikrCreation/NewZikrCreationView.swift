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
    
    var body: some View {
        Form {
            TextField(String.text.textField.placeholder.zikrName, text: $name)
                .tint(Color.app.tint.primary)
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                countService.createZikr(name: name, resetPeriod: resetPeriod)
                dismiss()
            } label: {
                Text(String.text.button.create)
                    .font(.app.font(.m).weight(.semibold))
                    .foregroundStyle(.black)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 12)
                    .background(.white, in: .capsule)
            }
            .disabled(!countService.isNewZikrNameValid(name))
        }
    }
}

#Preview {
    NewZikrCreationView(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
}
