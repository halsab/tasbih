//
//  ZikrsScreen+RowView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension ZikrsScreen {
    struct RowView: View {
        @Bindable var zikr: ZikrModel
        
        var body: some View {
            Text(zikr.name)
        }
    }
}

#Preview {
    ZikrsScreen.RowView(zikr: .init(name: "Zikr"))
}
