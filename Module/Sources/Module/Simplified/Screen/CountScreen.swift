//
//  CountScreen.swift
//  Module
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI
import SwiftData

public struct CountScreen: View {
    @State private var viewModel: ViewModel
    
    public var body: some View {
        ContentView()
    }
    
    public init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

#Preview {
    CountScreen(modelContext: ZikrModel.previewContainer.mainContext)
}

// MARK: - ContentView

private extension CountScreen {
    @ViewBuilder
    func ContentView() -> some View {
        switch viewModel.contentState {
        case .empty:
            Text("empty")
        case .main:
            Text("main")
        }
    }
}
