//
//  ZikrsView.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 23.10.2024.
//

import SwiftUI
import SwiftData
import AppUIKit

struct ZikrsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ZikrModel.date, order: .reverse) private var zikrs: [ZikrModel]
    @State private var newZirkName = ""
    @State private var showZikrCreateForm = false
    @State private var selectedZikr: ZikrModel?
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedZikr) {
                ForEach(zikrs) { zikr in
                    ZikrView(zikr: zikr)
                        .swipeActions(edge: .leading) {
                            Button(String.text.button.select) {
                                selectZikr(zikr)
                            }
                            .tint(.app.highlight)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                deleteZikr(zikr)
                            } label: {
                                Label(String.text.button.delete, systemImage: .text.systemName.trash_fill)
                            }
                        }
                }
            }
            .navigationTitle(String.text.title.zikrs)
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
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        decreaseCount()
                    } label: {
                        Image(systemName: "minus.square.fill")
                            .font(.app.mTitle)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        increaseCount()
                    } label: {
                        Image(systemName: "plus.square.fill")
                            .font(.app.mTitle)
                    }
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
    
    private func deleteZikr(_ zikr: ZikrModel) {
        if zikr.isSelected, let newSelectedZikr = zikrs.first(where: { $0.id != zikr.id }) {
            newSelectedZikr.isSelected = true
        }
        modelContext.delete(zikr)
        try? modelContext.save()
    }
    
    private func selectZikr(_ zikr: ZikrModel) {
        zikrs.forEach {
            $0.isSelected = false
        }
        zikr.isSelected = true
        try? modelContext.save()
    }
    
    private func increaseCount() {
        guard let zikr = zikrs.first(where: \.isSelected) else { return }
        withAnimation {
            zikr.count += 1
            zikr.date = .now
            try? modelContext.save()
        }
    }
    
    private func decreaseCount() {
        guard let zikr = zikrs.first(where: \.isSelected) else { return }
        withAnimation {
            if zikr.count > 0 {
                zikr.count -= 1
                zikr.date = .now
                try? modelContext.save()
            }
        }
    }
}

#Preview {
    ZikrsView()
        .tint(.app.tint)
        .preferredColorScheme(.dark)
}
