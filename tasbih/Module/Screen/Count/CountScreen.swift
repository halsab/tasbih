//
//  CountScreen.swift
//  Module
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

struct CountScreen: View {
    @Bindable var countService: CountService
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ContentView(countService: countService)
            .safeAreaPadding()
            .sheet(isPresented: $countService.showZikrsSheet) {
                NavigationStack {
                    ZikrsScreen(countService: countService)
                }
            }
            .onChange(of: scenePhase) { _, newValue in
                if newValue == .active {
                    countService.refreshZikrs()
                }
            }
    }
}

#Preview {
    CountScreen(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
}
