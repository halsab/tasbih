//
//  CountScreen+ZikrNameView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct ZikrNameView: View {
        let name: String
        
        var body: some View {
            Text(name)
                .font(.app.font(.m, .bold))
                .foregroundStyle(Color.secondary)
                .lineLimit(1)
        }
    }
}
