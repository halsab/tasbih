//
//  ZikrsScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

struct ZikrsScreen: View {
    @Bindable var countService: CountService
        
    var body: some View {
        ContentView(countService: countService)
    }
}

#Preview {
    ZikrsScreen(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
}

/*
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
                    .buttonStyle(TextButtonStyle())
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
*/

/*
struct ZikrView: View {
    
    @Bindable var zikr: ZikrModel
    
    let onTap: (_ id: UUID) -> Void
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ZikrModel.name) private var zikrs: [ZikrModel]
    
    @State private var showZikrDeleteAlert = false
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                decreaseCount()
            } label: {
                ZStack {
                    Color.system.secondaryFill
                        .frame(width: 48)
                    Image.app.button.decrease
                        .tint(.secondary)
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(zikr.name)
                        .font(.app.font(.m, .bold))
                        .foregroundStyle(zikr.isSelected ? Color.app.highlight : Color.primary)
                    
                    Text(zikr.date.formatted(date: .numeric, time: .shortened))
                        .font(.app.font(.xs))
                        .foregroundStyle(Color.secondary)
                }
                
                Spacer()
                
                Text("\(zikr.count)")
                    .contentTransition(.numericText())
                    .font(.app.font(.xxxl, .bold))
                    .foregroundStyle(Color.secondary)
            }
            .padding(8)
            .background(.background.secondary)
            .simultaneousGesture(
                LongPressGesture()
                    .onEnded { _ in
                        showZikrDeleteAlert.toggle()
                    }
            )
            .highPriorityGesture(
                TapGesture()
                    .onEnded {
                        onTap(zikr.id)
                    }
            )
            
            Button {
                increaseCount()
            } label: {
                ZStack {
                    Color.system.secondaryFill
                        .frame(width: 48)
                    Image.app.button.increase
                        .tint(.secondary)
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .clipShape(.rect(cornerRadius: 16))
        .alert(String.text.alert.delelteZikr + " \(zikr.name)?", isPresented: $showZikrDeleteAlert) {
            Button(String.text.button.delete, role: .destructive, action: deleteZikr)
            Button(String.text.button.cancel, role: .cancel) {}
        }
    }
    
    private func increaseCount() {
        guard let zikr = zikrs.first(where: { $0.id == zikr.id }) else { return }
        withAnimation {
            zikr.count += 1
            zikr.date = .now
            try? modelContext.save()
        }
    }
    
    private func decreaseCount() {
        guard let zikr = zikrs.first(where: { $0.id == zikr.id }) else { return }
        withAnimation {
            if zikr.count > 0 {
                zikr.count -= 1
                zikr.date = .now
                try? modelContext.save()
            }
        }
    }
    
    private func deleteZikr() {
        if zikr.isSelected, let newSelectedZikr = zikrs.first(where: { $0.id != zikr.id }) {
            newSelectedZikr.isSelected = true
        }
        withAnimation {
            modelContext.delete(zikr)
            try? modelContext.save()
        }
    }
}
*/
