//
//  TintButtonTextStyle.swift
//  muslimTools
//
//  Created by halsab on 12.11.2022.
//

import SwiftUI

struct TintButtonTextStyle: ViewModifier {
    let tint: Color
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .lineLimit(1)
            .font(.system(.headline))
            .background(tint)
            .foregroundColor(.bg)
            .clipShape(Capsule())
    }
}
