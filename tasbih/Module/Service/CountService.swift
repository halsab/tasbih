//
//  CountService.swift
//  Module
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI
import SwiftData

@MainActor
@Observable
final class CountService {
    
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
    
    private var i = 0
    
    private let neutralHapticGenerator: UIImpactFeedbackGenerator
    private let positiveHapticGenerator: UINotificationFeedbackGenerator
    private let negativeHapticGenerator: UINotificationFeedbackGenerator
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.neutralHapticGenerator = UIImpactFeedbackGenerator(style: .light)
        self.positiveHapticGenerator = UINotificationFeedbackGenerator()
        self.negativeHapticGenerator = UINotificationFeedbackGenerator()
        fetchData()
        updateContentState()
    }
}

// MARK: - Actions

extension CountService {
    func createZikr(name: String) {
        let zikr = ZikrModel(name: name)
        zikrs.forEach {
            $0.isSelected = false
        }
        modelContext.insert(zikr)
        saveContext()
        fetchData()
        positiveFeedback()
    }
    
    func deleteZikr(zikr: ZikrModel) {
        modelContext.delete(zikr)
        saveContext()
        fetchData()
        updateContentState()
        negativeFeedback()
    }
    
    func increment(zikr: ZikrModel) {
        zikr.count += 1
        saveContext()
        neutralFeedback()
    }
    
    func decrement(zikr: ZikrModel) {
        guard zikr.count > 0 else { return }
        zikr.count -= 1
        saveContext()
        neutralFeedback()
    }
    
    func reset(zikr: ZikrModel) {
        zikr.count = 0
        saveContext()
        negativeFeedback()
    }
    
    func select(zikr: ZikrModel) {
        zikrs.forEach {
            $0.isSelected = false
        }
        zikr.isSelected = true
        selectedZikr = zikr
        saveContext()
        neutralFeedback()
    }
    
    func isNewZikrNameValid(_ name: String) -> Bool {
        !(name.isEmptyCompletely || isZikrExistWithName(like: name))
    }
}

// MARK: - Helpers

private extension CountService {
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
    
    func isZikrExistWithName(like name: String) -> Bool {
        zikrs.contains(where: { $0.name.like(string: name) })
    }
}

// MARK: - Feedback Actions

extension CountService {
    private func positiveFeedback() {
        positiveHapticGenerator.notificationOccurred(.success)
    }
    
    private func negativeFeedback() {
        negativeHapticGenerator.notificationOccurred(.error)
    }
    
    func neutralFeedback() {
        neutralHapticGenerator.impactOccurred()
    }
}

// MARK: - ContentState

extension CountService {
    enum ContentState {
        case empty, main
    }
}

// MARK: - HeaderState

extension CountService {
    enum HeaderState {
        case compact, full
    }
}
