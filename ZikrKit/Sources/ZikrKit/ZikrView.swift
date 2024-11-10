//
//  ZikrView.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 01.11.2024.
//

import SwiftUI
import SwiftData

struct ZikrView: View {
    
    @Bindable var zikr: ZikrModel
    
    let onTap: (_ id: UUID) -> Void
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ZikrModel.name) private var zikrs: [ZikrModel]
    
    @State private var showZikrDeleteAlert = false
    
    var body: some View {
        HStack {            
            Button {} label: {
                ZStack {
                    Color.system.secondaryFill
                        .frame(width: 48)
                    Image.app.button.decrease
                        .tint(.secondary)
                }
            }
            .simultaneousGesture(
                LongPressGesture()
                    .onEnded { _ in
                        showZikrDeleteAlert.toggle()
                    }
            )
            .highPriorityGesture(
                TapGesture()
                    .onEnded {
                        decreaseCount()
                    }
            )
            
            HStack {
                VStack(alignment: .leading) {
                    Text(zikr.name)
                        .font(.app.font(.m, .bold))
                        .foregroundStyle(zikr.isSelected ? Color.app.tint : Color.primary)
                    
                    Text(zikr.date.formatted(date: .numeric, time: .shortened))
                        .font(.app.font(.xs))
                        .foregroundStyle(Color.secondary)
                }
                .onTapGesture {
                    onTap(zikr.id)
                }
                
                Spacer()
                
                Text("\(zikr.count)")
                    .contentTransition(.numericText())
                    .font(.app.font(.xxxl, .bold))
                    .foregroundStyle(Color.secondary)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            
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
        .background(.background.secondary)
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
        modelContext.delete(zikr)
        try? modelContext.save()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ZikrView(zikr: .init(name: "Zikr")) { _ in }
        .padding(16)
        .preferredColorScheme(.dark)
        .tint(.app.tint)
}
