//
//  ZikrsView.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 23.10.2024.
//

import SwiftUI
import SwiftData
import Helper

struct ZikrsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ZikrModel.name) private var zikrs: [ZikrModel]
    @State private var newZirkName = ""
    @State private var showZikrCreateForm = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(zikrs) { zikr in
                        ZikrView(zikr: zikr) { id in
                            selectZikr(id: id)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
                        showZikrCreateForm.toggle()
                    } label: {
                        Text(String.text.button.create.uppercased())
                    }
                    .buttonStyle(CustomButtonStyle())
                }
                
                ToolbarItem(placement: .principal) {
                    Text(String.text.title.zikrs)
                        .font(.app.font(.m, .bold))
                }
            }
            .alert(String.text.alert.createNewZikr, isPresented: $showZikrCreateForm) {
                TextField(String.text.textField.placeholder.zikrName, text: $newZirkName)
                Button(String.text.button.create, action: createZikr)
                    .disabled(newZirkName.isEmpty || zikrs.contains(where: { $0.name == newZirkName }))
                Button(String.text.button.cancel, role: .cancel) {
                    newZirkName = .text.empty
                }
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
    
    private func selectZikr(id: UUID) {
        withAnimation {
            zikrs.forEach {
                $0.isSelected = $0.id == id
            }
            try? modelContext.save()
        }
    }
}

#Preview {
    ZikrsView()
        .tint(.app.tint)
        .preferredColorScheme(.dark)
}
