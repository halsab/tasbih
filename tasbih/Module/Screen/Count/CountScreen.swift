//
//  CountScreen.swift
//  Module
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI
import SwiftData

struct CountScreen: View {
    @State private var viewModel: ViewModel
    
    var body: some View {
        ContentView(viewModel: viewModel)
            .safeAreaPadding()
            .sheet(isPresented: $viewModel.showZikrsSheet) {
                Text("Zikrs")
            }
    }
    
    init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

#Preview {
    CountScreen(modelContext: ZikrModel.previewContainer.mainContext)
}
