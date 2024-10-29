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
    @Query(sort: \ZikrModel.date, order: .reverse) private var zikrs: [ZikrModel]
    @State private var newZirkName = ""
    @State private var showZikrCreateForm = false

    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            if let zikr = zikrs.first {
                HeaderView(zikr: zikr)
                
                CentralView(zikr: zikr)                
            
                FooterView(zikr: zikr)
            } else {
                Button("Add", systemImage: "plus") {
                    showZikrCreateForm.toggle()
                }
            }
        }
        .padding([.bottom, .leading, .trailing])
        .alert("Create your new zikr", isPresented: $showZikrCreateForm) {
            TextField("Zikr name", text: $newZirkName)
            Button("Create", action: createZikr)
            Button("Cancel", role: .cancel) {
                newZirkName = ""
            }
        }
    }
    
    private func createZikr() {
        let zikr = ZikrModel(name: newZirkName)
        newZirkName = ""
        modelContext.insert(zikr)
    }
}

#Preview {
    CountScreen()
        .environmentObject(CountManager())
        .preferredColorScheme(.dark)
}
