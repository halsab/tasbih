//
//  CountScreen+ViewModel.swift
//  Module
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI
import SwiftData

extension CountScreen {
    @Observable
    final class ViewModel {
        
        var zikrs = [ZikrModel]()
        var contentState: ContentState = .empty
        
        @ObservationIgnored
        private var modelContext: ModelContext
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
            contentState = zikrs.isEmpty ? .empty : .main
        }
    }
}

// MARK: - Helpers

private extension CountScreen.ViewModel {
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<ZikrModel>(sortBy: [SortDescriptor(\.name)])
            zikrs = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
}

// MARK: - ContentState

extension CountScreen.ViewModel {
    enum ContentState {
        case empty, main
    }
}
