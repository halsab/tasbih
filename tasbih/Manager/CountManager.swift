//
//  CountManager.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI
import Combine

final class CountManager: ObservableObject {
    
    // MARK: Published properties
    
    @Published var selectedCountId: Int = 0
    @Published private(set) var counts: [CountModel] = []
    
    // MARK: Computed properties
    
    var loops: Int {
        guard let index = index() else { return 0 }
        return counts[index].loops
    }
    var loopSize: Int {
        guard let index = index() else { return 0 }
        return counts[index].loopSize
    }
    var value: Int {
        guard let index = index() else { return 0 }
        return counts[index].value
    }
    var total: Int {
        guard let index = index() else { return 0 }
        return counts[index].total
    }
    var goal: Int {
        guard let index = index() else { return 0 }
        return counts[index].goal
    }
    
    // MARK: Private properties
    
    private var appManager = AppManager()
    private let defaultCountsInfo: [(id: Int, key: String, loopSize: Int)] = [
        (0, "countModel0Key", 33),
        (1, "countModel1Key", 100),
        (2, "countModel2Key", 1000)
    ]
    private var anyCancellables = Set<AnyCancellable>()
    
    // MARK: Init
    
    init() {
        initCountModels()
    }
}

// MARK: - Internal Methods
 
extension CountManager {
    
    func increment() {
        guard let index = index() else { return }
        counts[index].increment()
        hapticFeedback()
        // TODO: Save +1
    }
    
    func decrement() {
        guard let index = index() else { return }
        counts[index].decrement()
        hapticFeedback()
        // TODO: Save -1
    }
    
    func reset() {
        guard let index = index() else { return }
        counts[index].reset()
    }
    
    func hardReset() {
        guard let index = index() else { return }
        counts[index].hardReset()
    }
    
    func hardResetAll() {
        counts.enumerated()
            .forEach {
                counts[$0.offset].hardReset()
            }
    }
    
    func saveAll() {
        zip(counts, defaultCountsInfo).forEach { (count, info) in
            try? UserDefaults.standard.saveModel(count, forKey: info.key)
        }
    }
    
    func setLoopSize(_ newLoopSize: Int, for id: Int) {
        guard let index = index(of: id) else { return }
        counts[index].setLoopSize(newLoopSize)
    }
    
    func setGoal(_ newGoal: Int, for id: Int) {
        guard let index = index(of: id) else { return }
        counts[index].setGoal(newGoal)
    }
}


// MARK: - Private Methods
 
extension CountManager {
    
    private func initCountModels() {
        defaultCountsInfo.forEach {
            do {
                let countModel: CountModel = try UserDefaults.standard.getModel(forKey: $0.key)
                counts.append(countModel)
            } catch {
                let countModel = CountModel(id: $0.id, loopSize: $0.loopSize)
                counts.append(countModel)
                try? UserDefaults.standard.saveModel(countModel, forKey: $0.key)
            }
        }
        selectedCountId = counts.first?.id ?? .init()
    }

    private func index(of id: Int? = nil) -> Int? {
        let selectedId = id ?? selectedCountId
        return counts.enumerated().first(where: { $0.element.id == selectedId })?.offset
    }
    
    private func hapticFeedback() {
        if value == 0 {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.success)
        } else {
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.prepare()
            generator.impactOccurred()
        }
    }
}
