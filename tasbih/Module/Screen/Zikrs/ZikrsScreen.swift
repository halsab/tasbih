//
//  ZikrsScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

struct ZikrsScreen: View {
    @Bindable var countService: CountService
    
    @State private var showNewZikrCreationSheet = false
        
    var body: some View {
        ContentView(countService: countService, addNewZikr: $showNewZikrCreationSheet)
            .sheet(isPresented: $showNewZikrCreationSheet) {
                NavigationStack {
                    IntroScreen(countService: countService)
                }
                .presentationDetents([.large])
            }
            .task {
                await NewZikrButtonTip.zikrsOpenedCount.donate()
            }
    }
}

#Preview {
    ZikrsScreen(
        countService: CountService(modelContext: ZikrModel.previewContainer.mainContext)
    )
}
