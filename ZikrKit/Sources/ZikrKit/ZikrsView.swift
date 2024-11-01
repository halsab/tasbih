//
//  ZikrsView.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 23.10.2024.
//

import SwiftUI
import SwiftData

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
                    zikrView(zikr: zikr)
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
                    Button(String.text.button.add, systemImage: .text.systemName.plus_circle) {
                        showZikrCreateForm.toggle()
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
    
    @ViewBuilder
    private func zikrView(zikr: ZikrModel) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(zikr.name)
                    .font(.app.mTitle)
                    .foregroundStyle(zikr.isSelected ? Color.app.tint : Color.primary)
                
                Text(zikr.date.formatted(date: .numeric, time: .shortened))
                    .font(.app.footnote)
                    .foregroundStyle(Color.secondary)
            }
            
            Spacer()
            
            Text("\(zikr.count)")
                .font(.app.lTitle)
                .foregroundStyle(Color.secondary)
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
}

#Preview {
    ZikrsView()
        .tint(.app.tint)
}
