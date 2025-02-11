//
//  ZikrCreationAlertView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 11.02.2025.
//

import SwiftUI

struct ZikrCreationAlertView: View {
    @Binding var name: String
    let isValid: () -> Bool
    let action: () -> Void
    
    var body: some View {
        TextField(String.text.textField.placeholder.zikrName, text: $name)
        Button(String.text.button.create) {
            action()
            name = ""
        }
        .disabled(!isValid())
        Button(String.text.button.cancel, role: .cancel) {
            name = ""
        }
    }
}

#Preview {
    @Previewable @State var isPresented = true
    @Previewable @State var name = ""
    VStack {}
        .alert(String.text.alert.createFirstZikr, isPresented: $isPresented) {
            ZikrCreationAlertView(name: $name, isValid: { false }, action: {})
        }
}
