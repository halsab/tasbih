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
        counts.forEach { Log.info($0.loopSize, $0) }
    }
}

// MARK: - Internal Methods
 
extension CountManager {
    
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
        Log.info("Save")
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
    
    func countDay(at date: Date) -> CountDay {
        if let dateCountKey = countKey(for: date),
           let data = UserDefaults.standard.data(forKey: dateCountKey),
           let countDay = try? JSONDecoder().decode(CountDay.self, from: data) {
            return countDay
        } else {
            return .init(date: date, count: 0, goal: goal * loopSize)
        }
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
    
    private func countKey(for date: Date) -> String? {
        guard let index = index() else { return nil }
        let dateComponents = Calendar.user().dateComponents([.day, .month, .year], from: date)
        let stringDate = [dateComponents.day, dateComponents.month, dateComponents.year]
            .compactMap { $0 }
            .map { String($0) }
            .joined()
        let key = stringDate + String(counts[index].id) + "todayCountKey"
        return key
    }
    
    private func saveTodayValue(_ value: Int) {
        DispatchQueue(label: "TodayCountSavingQueue", qos: .userInitiated).async {
            guard let todayCountKey = self.countKey(for: Date.user()) else { return }
            var countDay = self.countDay(at: Date.user())
            countDay.count = max(0, countDay.count + value)
            countDay.goal = self.goal * self.loopSize
            try? UserDefaults.standard.saveModel(countDay, forKey: todayCountKey)
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
