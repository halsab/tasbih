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
    @Query private var zikrs: [ZikrModel]
    @State private var newZirkName = ""
    @State private var showZikrCreateForm = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(zikrs) { zikr in
                    NavigationLink(value: zikr) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(zikr.name)
                                    .font(.app.mTitle)
                                    .foregroundStyle(Color.primary)
                                
                                Text(zikr.date.formatted(date: .long, time: .shortened))
                                    .font(.app.footnote)
                                    .foregroundStyle(Color.secondary)
                            }
                            
                            Spacer()
                            
                            Text("\(zikr.count)")
                                .font(.app.lTitle)
                                .foregroundStyle(Color.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteZikrs)
            }
            .navigationTitle("Zikrs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Add", systemImage: "plus") {
                    showZikrCreateForm.toggle()
                }
            }
            .alert("Create your new zikr", isPresented: $showZikrCreateForm) {
                TextField("Zikr name", text: $newZirkName)
                Button("Create", action: createZikr)
                Button("Cancel", role: .cancel) {}
            }
            .navigationDestination(for: ZikrModel.self) { zikr in
                ZikrEditView(zikr: zikr)
            }
        }
    }
    
    private func createZikr() {
        let zikr = ZikrModel(name: newZirkName)
        modelContext.insert(zikr)
    }
    
    private func deleteZikrs(_ indexSet: IndexSet) {
        for index in indexSet {
            let zikr = zikrs[index]
            modelContext.delete(zikr)
        }
    }
}

#Preview {
    ZikrsView()
        .tint(.app.tint)
}
