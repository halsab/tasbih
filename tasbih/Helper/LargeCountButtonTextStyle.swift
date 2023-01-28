//
//  LargeCountButtonTextStyle.swift
//  muslimTools
//
//  Created by halsab on 12.11.2022.
//

import SwiftUI

struct LargeCountButtonTextStyle: ViewModifier {
    let tint: Color
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .padding()
            .foregroundColor(tint)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.system(size: 120, weight: .black, design: .rounded))
    }
}

