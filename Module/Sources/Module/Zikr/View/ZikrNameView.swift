//
//  SwiftUIView.swift
//  Module
//
//  Created by Khalil Sabirov on 28.01.2025.
//

import SwiftUI

struct ZikrNameView: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.app.font(.m, .bold))
            .foregroundStyle(Color.secondary)
            .lineLimit(1)
    }
}

#Preview {
    ZikrNameView(name: "Zikr name")
}
