//
//  CountManager.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI
import Combine

final class CountManager: ObservableObject {

    @Published var selectedCountId: UUID = .init()
    @Published private(set) var counts: [CountModel] = .init()
    
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
    
    private let defaultCountsInfo: [(key: String, loopSize: Int)] = [
        ("countModel0Key", 33),
        ("countModel1Key", 100),
        ("countModel2Key", 1000)
    ]
    private var anyCancellables = Set<AnyCancellable>()
    
    init() {
        initCountModels()
        counts.forEach { Log.debug($0.loopSize, $0) }
    }
    
    func increment() {
        guard let index = index() else { return }
        counts[index].increment()
        hapticFeedback()
    }
    
    func decrement() {
        guard let index = index() else { return }
        counts[index].decrement()
        hapticFeedback()
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
        Log.debug("Save")
        zip(counts, defaultCountsInfo).forEach {
            if let data = try? JSONEncoder().encode($0.0) {
                UserDefaults.standard.set(data, forKey: $0.1.key)
            }
        }
    }
    
    func setLoopSize(_ newLoopSize: Int, for id: UUID) {
        guard let index = index(of: id) else { return }
        counts[index].setLoopSize(newLoopSize)
    }

    private func initCountModels() {
        defaultCountsInfo.forEach {
            if let data = UserDefaults.standard.data(forKey: $0.key),
               let model = try? JSONDecoder().decode(CountModel.self, from: data) {
                counts.append(model)
            } else {
                let model = CountModel(loopSize: $0.loopSize)
                counts.append(model)
                if let data = try? JSONEncoder().encode(model) {
                    UserDefaults.standard.set(data, forKey: $0.key)
                }
            }
        }
        selectedCountId = counts.first?.id ?? .init()
    }
    
    private func index(of id: UUID? = nil) -> Int? {
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
