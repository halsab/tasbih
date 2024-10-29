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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(zikrs) { zikr in
                    zikrView(zikr: zikr)
                        .swipeActions(edge: .leading) {
                            Button("Select") {
                                print("Awesome!")
                            }
                            .tint(.app.highlight)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                deleteZikr(zikr)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                }
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
                Button("Cancel", role: .cancel) {
                    newZirkName = ""
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
                    .foregroundStyle(Color.primary)
                
                Text(zikr.date.formatted(date: .numeric, time: .omitted))
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
        newZirkName = ""
        modelContext.insert(zikr)
    }
    
    private func deleteZikr(_ zikr: ZikrModel) {
        modelContext.delete(zikr)
    }
}

#Preview {
    ZikrsView()
        .tint(.app.tint)
}
