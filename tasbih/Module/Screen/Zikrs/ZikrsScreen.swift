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
                    NewZikrCreationView(countService: countService)
                }
                .presentationDetents([.medium, .large])
            }
    }
}

#Preview {
    ZikrsScreen(
        countService: CountService(modelContext: ZikrModel.previewContainer.mainContext)
    )
}
