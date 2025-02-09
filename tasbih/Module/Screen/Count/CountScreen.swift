//
//  CountScreen.swift
//  Module
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI
import SwiftData

struct CountScreen: View {
    @State private var countService: CountService
    
    var body: some View {
        ContentView(countService: countService)
            .safeAreaPadding()
            .sheet(isPresented: $countService.showZikrsSheet) {
                ZikrsScreen(countService: countService)
            }
    }
    
    init(modelContext: ModelContext) {
        let countService = CountService(modelContext: modelContext)
        _countService = State(initialValue: countService)
    }
}

#Preview {
    CountScreen(modelContext: ZikrModel.previewContainer.mainContext)
}
