//
//  ZikrsHScrollView.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 23.10.2024.
//

import SwiftUI

struct ZikrsHScrollView: View {
    
    var zikrs: [ZikrModel]
    
    @State private var showZikrs = false
    @State private var selectedZikr: ZikrModel?
    
    var body: some View {
        HStack {
            Picker("Zikr", selection: $selectedZikr) {
                ForEach(zikrs) { zikr in
                    Text(zikr.name)
                        .font(.app.mTitle)
                        .foregroundStyle(Color.app.tint)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 100)
            
            Button {
                showZikrs.toggle()
            } label: {
                Image.app.icon.list
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.shape(.app.tint))
            }
            .padding(8)
        }
        .sheet(isPresented: $showZikrs) {
            ZikrsView()
                .presentationDetents([.large, .medium])
        }
    }
}

#Preview {
    ZikrsHScrollView(zikrs: [
        .init(name: "Zikr 1", count: 123, loopSize: .m, date: .now),
        .init(name: "Zikr 2", count: 43, loopSize: .l, date: .now),
        .init(name: "Zikr 3", count: 532, loopSize: .m, date: .now),
        .init(name: "Zikr 4", count: 123, loopSize: .m, date: .now),
        .init(name: "Zikr 5", count: 43, loopSize: .l, date: .now),
        .init(name: "Zikr 6", count: 532, loopSize: .m, date: .now),
        .init(name: "Zikr 7", count: 123, loopSize: .m, date: .now),
        .init(name: "Zikr 8", count: 43, loopSize: .l, date: .now),
        .init(name: "Zikr 9", count: 532, loopSize: .m, date: .now),
    ])
    .tint(.app.tint)
}
