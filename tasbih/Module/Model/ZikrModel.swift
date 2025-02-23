//
//  ZikrModel.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 23.10.2024.
//

import Foundation
import SwiftData

@Model
final class ZikrModel: Identifiable {
    @Attribute(.unique)
    private(set) var id: UUID

    var loopSize: LoopSize
    var isSelected: Bool

    private(set) var name: String
    private(set) var resetPeriod: ResetPeriod
    private(set) var dailyCounts: [Count]
    private(set) var periodCount: UInt
    
    @Transient
    var currentLoopCount: UInt {
        periodCount % loopSize.rawValue
    }
    @Transient
    var loopsCount: UInt {
        periodCount / loopSize.rawValue
    }
    @Transient
    var date: Date {
        dailyCounts[0].date
    }
    @Transient
    var count: UInt {
        periodCount
    }
    
    init(name: String, resetPeriod: ResetPeriod) {
        self.id = UUID()
        self.name = name
        self.loopSize = .s
        self.isSelected = true
        self.resetPeriod = resetPeriod
        self.dailyCounts = [.init(value: 0, date: .now)]
        self.periodCount = 0
    }
    
    func increment() {
        setDailyCountValue(dailyCounts[0].value + 1)
        setPeriodCountValue(periodCount + 1)
    }
    
    func decrement() {
        setDailyCountValue(dailyCounts[0].value - 1)
        setPeriodCountValue(periodCount - 1)
    }
    
    func reset() {
        setDailyCountValue(0)
        setPeriodCountValue(0)
    }
    
    func refresh() {
        setDailyCountValue(dailyCounts[0].value)
        setPeriodCountValue(periodCount)
    }
    
    private func setDailyCountValue(_ value: UInt) {
        if dailyCounts[0].date.isToday {
            dailyCounts[0].value = value
        } else {
            let newCount = Count(value: 0, date: Date())
            dailyCounts.insert(newCount, at: 0)
        }
    }
    
    private func setPeriodCountValue(_ value: UInt) {
        let lastCountDate = dailyCounts[0].date
        let isCurrentPeriod = switch resetPeriod {
        case .day: lastCountDate.isToday
        case .week: lastCountDate.isInThisWeek
        case .month: lastCountDate.isInThisMonth
        case .year: lastCountDate.isInThisYear
        case .infinity: true
        }
        if isCurrentPeriod {
            periodCount = value
        } else {
            periodCount = 0
        }
    }
}

@MainActor
extension ZikrModel {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: ZikrModel.self, configurations: config)
            
            for i in 0..<10 {
                let zikr = ZikrModel(name: "Zikr \(i)",
                                     resetPeriod: [.day, .month, .week, .year, .infinity].randomElement()!)
                zikr.isSelected = i == 0
                container.mainContext.insert(zikr)
            }
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
    
    static let previewModel: ZikrModel = .init(name: "Preview Zikr", resetPeriod: .day)
}
