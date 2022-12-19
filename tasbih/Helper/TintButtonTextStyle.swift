//
//  TintButtonTextStyle.swift
//  muslimTools
//
//  Created by halsab on 12.11.2022.
//

import SwiftUI

struct TintButtonTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .lineLimit(1)
            .font(.system(.headline))
            .background(.base)
            .foregroundColor(.bg)
            .clipShape(Capsule())
    }
}
