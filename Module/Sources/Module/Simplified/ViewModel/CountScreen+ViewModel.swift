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
        var headerState: HeaderState = .full
        var loopSize: LoopSize = .s {
            didSet { handle(new: loopSize) }
        }
        var showZikrsSheet = false
        
        @ObservationIgnored
        private var modelContext: ModelContext
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
            updateContentState()
        }
    }
}

// MARK: - Actions

extension CountScreen.ViewModel {
    func createZikr(name: String) {
        let zikr = ZikrModel(name: name)
        zikrs.forEach {
            $0.isSelected = false
        }
        modelContext.insert(zikr)
        saveContext()
        fetchData()
    }
    
    func deleteZikr(zikr: ZikrModel) {
        modelContext.delete(zikr)
        saveContext()
        fetchData()
        updateContentState()
    }
    
    func increment(zikr: ZikrModel) {
        zikr.count += 1
        saveContext()
    }
    
    func decrement(zikr: ZikrModel) {
        guard zikr.count > 0 else { return }
        zikr.count -= 1
        saveContext()
    }
    
    func reset(zikr: ZikrModel) {
        zikr.count = 0
        saveContext()
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
    
    func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save contxt: \(error.localizedDescription)")
        }
    }
    
    func handle(new loopSize: LoopSize) {
        headerState = switch loopSize {
        case .infinity: .compact
        default: .full
        }
        
        selectedZikr?.loopSize = loopSize
        saveContext()
    }
    
    func updateContentState() {
        contentState = zikrs.isEmpty ? .empty : .main
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
