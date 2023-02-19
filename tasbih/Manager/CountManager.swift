//
//  CountManager.swift
//  tasbih
//
//  Created by Khalil Sabirov on 28.01.2023.
//

import SwiftUI
import Combine

final class CountManager: ObservableObject {

    @Published var selectedCountId: Int = 0
    @Published private(set) var counts: [CountModel] = []
    
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
    
    private var appManager = AppManager()
    private let defaultCountsInfo: [(id: Int, key: String, loopSize: Int)] = [
        (0, "countModel0Key", 33),
        (1, "countModel1Key", 100),
        (2, "countModel2Key", 1000)
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
        saveTodayValue(1)
    }
    
    func decrement() {
        guard let index = index() else { return }
        counts[index].decrement()
        hapticFeedback()
        saveTodayValue(-1)
    }
    
    func reset() {
        guard let index = index() else { return }
        let resetValue = value - loops * loopSize
        counts[index].reset()
        saveTodayValue(-resetValue)
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
        Log.info("Save")
        zip(counts, defaultCountsInfo).forEach { (count, info) in
            if let data = try? JSONEncoder().encode(count) {
                UserDefaults.standard.set(data, forKey: info.key)
            }
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
    
    func value(at date: Date) -> Int {
        guard let dateCountKey = countKey(for: date) else { return 0 }
        return UserDefaults.standard.integer(forKey: dateCountKey)
    }

    private func initCountModels() {
        defaultCountsInfo.forEach {
            if let data = UserDefaults.standard.data(forKey: $0.key),
               let model = try? JSONDecoder().decode(CountModel.self, from: data) {
                counts.append(model)
            } else {
                let model = CountModel(id: $0.id, loopSize: $0.loopSize)
                counts.append(model)
                if let data = try? JSONEncoder().encode(model) {
                    UserDefaults.standard.set(data, forKey: $0.key)
                }
            }
        }
        selectedCountId = counts.first?.id ?? .init()
    }
    
    private func index(of id: Int? = nil) -> Int? {
        let selectedId = id ?? selectedCountId
        return counts.enumerated().first(where: { $0.element.id == selectedId })?.offset
    }
    
    private func countKey(for date: Date) -> String? {
        guard let index = index() else { return nil }
        let dateComponents = Calendar.user.dateComponents([.day, .month, .year], from: date)
        let stringDate = [ dateComponents.day, dateComponents.month, dateComponents.year ]
            .compactMap { $0 }
            .map { String($0) }
            .joined()
        let key = stringDate + String(counts[index].id) + "todayCountKey"
        return key
    }
    
    private func saveTodayValue(_ value: Int) {
        DispatchQueue(label: "TodayCountSavingQueue", qos: .userInitiated).async {
            guard let todayCountKey = self.countKey(for: Date.current()) else { return }
            var todayValue = self.value(at: Date.current())
            todayValue = max(0, todayValue + value)
            UserDefaults.standard.set(todayValue, forKey: todayCountKey)
        }
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
