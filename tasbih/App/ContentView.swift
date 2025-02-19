//
//  ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Bindable var countService: CountService
    
    var body: some View {
        Group {
            switch countService.contentState {
            case .empty: IntroScreen(countService: countService)
            case .main: CountScreen(countService: countService)
            }
        }
        .statusBar(hidden: true)
    }
}

#Preview {
    ContentView(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
}
