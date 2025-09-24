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
    var loopSize: LoopSize = ._33 {
        didSet { handle(new: loopSize) }
    }
    var showZikrsSheet = false
    
    @ObservationIgnored
    private var modelContext: ModelContext
    
    private let lightHapticGenerator: UIImpactFeedbackGenerator
    private let mediumHapticGenerator: UIImpactFeedbackGenerator
    private let heavyHapticGenerator: UIImpactFeedbackGenerator
    private let negativeHapticGenerator: UINotificationFeedbackGenerator
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.lightHapticGenerator = UIImpactFeedbackGenerator(style: .light)
        self.mediumHapticGenerator = UIImpactFeedbackGenerator(style: .medium)
        self.heavyHapticGenerator = UIImpactFeedbackGenerator(style: .heavy)
        self.negativeHapticGenerator = UINotificationFeedbackGenerator()
        fetchData()
        if selectedZikr == nil {
            selectFirstZikr()
        }
        updateUIState()
    }
}

// MARK: - Internal methods

extension CountService {
    func createZikr(name: String, resetPeriod: ResetPeriod = .day) {
        let zikr = ZikrModel(name: name, resetPeriod: resetPeriod)
        zikrs.forEach {
            $0.isSelected = false
        }
        modelContext.insert(zikr)
        saveContext()
        fetchData()
        updateUIState()
        positiveFeedback()
    }
    
    func deleteZikr(zikr: ZikrModel) {
        modelContext.delete(zikr)
        zikrs.removeAll(where: { $0.id == zikr.id })
        if zikr.isSelected {
            selectFirstZikr()
        }
        saveContext()
        fetchData()
        updateUIState()
        negativeFeedback()
    }
    
    func increment(zikr: ZikrModel) {
        zikr.increment()
        saveContext()
        countChangeFeedback()
    }
    
    func decrement(zikr: ZikrModel) {
        zikr.decrement()
        saveContext()
        countChangeFeedback()
    }
    
    func reset(zikr: ZikrModel) {
        zikr.reset()
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
        updateUIState()
        neutralFeedback()
    }
    
    func refreshZikrs() {
        zikrs.forEach {
            $0.refresh()
        }
        saveContext()
    }
    
    func isNewZikrNameValid(_ name: String) -> Bool {
        !(name.isEmptyCompletely || isZikrExistWithName(like: name))
    }
    
    func hapticFeedback() {
        neutralFeedback()
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
        case .inf: .compact
        default: .full
        }
        
        selectedZikr?.loopSize = loopSize
        saveContext()
    }
    
    func updateUIState() {
        withAnimation {
            contentState = zikrs.isEmpty ? .empty : .main
            loopSize = selectedZikr?.loopSize ?? ._33
        }
    }
    
    func isZikrExistWithName(like name: String) -> Bool {
        zikrs.contains(where: { $0.name.like(string: name) })
    }
    
    func selectFirstZikr() {
        selectedZikr = zikrs.first
        zikrs.first(where: { $0.id == selectedZikr?.id })?.isSelected = true
    }
}

// MARK: - Haptic Feedback

private extension CountService {
    func positiveFeedback() {
        Task { @MainActor in
            heavyHapticGenerator.impactOccurred()
            try? await Task.sleep(for: .milliseconds(20))
            heavyHapticGenerator.impactOccurred()
            try? await Task.sleep(for: .milliseconds(20))
            mediumHapticGenerator.impactOccurred()
            try? await Task.sleep(for: .milliseconds(20))
            mediumHapticGenerator.impactOccurred()
            try? await Task.sleep(for: .milliseconds(20))
            heavyHapticGenerator.impactOccurred()
            try? await Task.sleep(for: .milliseconds(20))
            heavyHapticGenerator.impactOccurred()
        }
    }
    
    func negativeFeedback() {
        negativeHapticGenerator.notificationOccurred(.error)
    }
    
    func neutralFeedback() {
        lightHapticGenerator.impactOccurred()
    }
    
    func countChangeFeedback() {
        if selectedZikr?.currentLoopCount == 0 {
            positiveFeedback()
        } else {
            neutralFeedback()
        }
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
