//
//  ZikrsScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

struct ZikrsScreen: View {
    @Bindable var countService: CountService
    
    var body: some View {
        List(countService.zikrs) {
            Text($0.name)
        }
    }
}

#Preview {
    ZikrsScreen(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
}
