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
        ContentView(countService: countService)
    }
}

#Preview {
    ZikrsScreen(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
}
