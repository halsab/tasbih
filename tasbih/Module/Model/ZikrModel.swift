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
        self.loopSize = ._33
        self.isSelected = true
        self.resetPeriod = resetPeriod
        self.dailyCounts = [.init(value: 0, date: .now)]
        self.periodCount = 0
    }
}

// MARK: - Methods

extension ZikrModel {
    func increment() {
        let date = dailyCounts[0].date
        setDailyCountValue(dailyCounts[0].value + 1, date: date)
        setPeriodCountValue(periodCount + 1, date: date)
    }
    
    func decrement() {
        let date = dailyCounts[0].date
        setDailyCountValue(dailyCounts[0].value - 1, date: date)
        setPeriodCountValue(periodCount - 1, date: date)
    }
    
    func reset() {
        let date = dailyCounts[0].date
        setDailyCountValue(0, date: date)
        setPeriodCountValue(0, date: date)
    }
    
    func refresh() {
        let date = dailyCounts[0].date
        setDailyCountValue(dailyCounts[0].value, date: date)
        setPeriodCountValue(periodCount, date: date)
    }
}

// MARK: - Helpers

private extension ZikrModel {
    func setDailyCountValue(_ value: UInt, date: Date) {
        if date.isToday {
            dailyCounts[0].value = value
        } else {
            let newCount = Count(value: 0, date: .now)
            dailyCounts.insert(newCount, at: 0)
        }
    }
    
    func setPeriodCountValue(_ value: UInt, date: Date) {
        let isCurrentPeriod = switch resetPeriod {
        case .day: date.isToday
        case .week: date.isInThisWeek
        case .month: date.isInThisMonth
        case .year: date.isInThisYear
        case .infinity: true
        }
        if isCurrentPeriod {
            periodCount = value
        } else {
            periodCount = 0
        }
    }
}

// MARK: - Static

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
