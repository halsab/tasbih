//
//  ZikrView.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 01.11.2024.
//

import SwiftUI

struct ZikrView: View {
    
    @Bindable var zikr: ZikrModel
    
    var body: some View {
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
                .contentTransition(.numericText())
                .font(.app.lTitle)
                .foregroundStyle(Color.secondary)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ZikrView(zikr: .init(name: "Zikr"))
        .padding(16)
        .preferredColorScheme(.dark)
        .tint(.app.tint)
}
