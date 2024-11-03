//
//  CountScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.09.2023.
//

import SwiftUI
import SwiftData
import HelperKit

public struct CountScreen: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var zikrs: [ZikrModel]
    @State private var newZirkName = String.text.empty
    @State private var showZikrCreateForm = false

    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            if let zikr = zikrs.first(where: \.isSelected) {
                HeaderView(zikr: zikr)
                
                CentralView(zikr: zikr)                
            
                FooterView(zikr: zikr)
            } else {
                Button(String.text.button.createFirstZikr, systemImage: .text.systemName.plus) {
                    showZikrCreateForm.toggle()
                }
                .foregroundStyle(Color.primary)
                .font(.app.mBody)
                .padding()
                .background(Color.app.tint)
                .clipShape(.capsule)
            }
        }
        .padding([.bottom, .leading, .trailing])
        .alert(String.text.alert.createFirstZikr, isPresented: $showZikrCreateForm) {
            TextField(String.text.textField.placeholder.zikrName, text: $newZirkName)
            Button(String.text.button.create, action: createZikr)
            Button(String.text.button.cancel, role: .cancel) {
                newZirkName = .text.empty
            }
        }
    }
    
    private func createZikr() {
        let zikr = ZikrModel(name: newZirkName)
        newZirkName = .text.empty
        zikrs.forEach {
            $0.isSelected = false
        }
        modelContext.insert(zikr)
        try? modelContext.save()
    }
}

#Preview {
    CountScreen()
        .preferredColorScheme(.dark)
}
