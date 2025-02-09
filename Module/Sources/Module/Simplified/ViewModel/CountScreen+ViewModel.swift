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
        var selectedZikr: ZikrModel?
        var contentState: ContentState = .empty
        var headerState: HeaderState = .compact
        var loopSize: LoopSize = .s
        
        @ObservationIgnored
        private var modelContext: ModelContext
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
            contentState = zikrs.isEmpty ? .empty : .main
        }
    }
}

// MARK: - Actions

extension CountScreen.ViewModel {
    func createZikr(name: String) {
        
    }
}

// MARK: - Helpers

private extension CountScreen.ViewModel {
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<ZikrModel>(sortBy: [SortDescriptor(\.name)])
            zikrs = try modelContext.fetch(descriptor)
            selectedZikr = zikrs.first(where: \.isSelected)
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

// MARK: - HeaderState

extension CountScreen.ViewModel {
    enum HeaderState {
        case compact, full
    }
}
