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
        dailyCounts.first?.date ?? .now
    }
    @Transient
    var count: UInt {
        periodCount
    }
    @Transient
    var lastCounts: [Count] {
        let countsToCheck = dailyCounts.sorted { $0.date > $1.date }.prefix(14)
        return (0..<7)
            .compactMap {
                Calendar.current.date(byAdding: .day, value: -$0, to: .now)
            }
            .map { date in
                let value = countsToCheck
                    .filter { Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day) }
                    .reduce(into: UInt(0)) { result, count in
                        result += count.value
                    }
                return .init(value: value, date: date)
            }
            .reversed()
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

    fileprivate init(name: String, periodCount: UInt, dailyCounts: [Count]) {
        self.id = UUID()
        self.name = name
        self.loopSize = ._33
        self.isSelected = true
        self.resetPeriod = .day
        self.dailyCounts = dailyCounts
        self.periodCount = periodCount
    }
}

// MARK: - Methods

extension ZikrModel {
    func increment() {
        normalizeCountsForCurrentDate()
        dailyCounts[0].value += 1
        periodCount += 1
    }

    func decrement() {
        normalizeCountsForCurrentDate()
        guard dailyCounts[0].value > 0, periodCount > 0 else { return }
        dailyCounts[0].value -= 1
        periodCount -= 1
    }

    func reset() {
        normalizeCountsForCurrentDate()
        dailyCounts[0].value = 0
        periodCount = 0
    }

    func refresh() {
        normalizeCountsForCurrentDate()
    }
}

// MARK: - Helpers

private extension ZikrModel {
    // Приводим историю к текущей дате до любых изменений счетчика.
    func normalizeCountsForCurrentDate() {
        dailyCounts.sort { $0.date > $1.date }

        if shouldResetPeriod(after: dailyCounts.first?.date) {
            periodCount = 0
        }

        moveTodayCountToFrontOrCreate()
    }

    func moveTodayCountToFrontOrCreate() {
        guard let todayIndex = dailyCounts.firstIndex(where: { $0.date.isToday }) else {
            dailyCounts.insert(.init(value: 0, date: .now), at: 0)
            return
        }

        guard todayIndex != 0 else { return }

        let todayCount = dailyCounts.remove(at: todayIndex)
        dailyCounts.insert(todayCount, at: 0)
    }

    func shouldResetPeriod(after date: Date?) -> Bool {
        guard let date else { return true }

        let isCurrentPeriod = switch resetPeriod {
        case .day: date.isToday
        case .week: date.isInThisWeek
        case .month: date.isInThisMonth
        case .year: date.isInThisYear
        case .infinity: true
        }

        return !isCurrentPeriod
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

    static let previewModel: ZikrModel = .init(
        name: "Preview Zikr",
        periodCount: (0..<1000).randomElement()!,
        dailyCounts: (0..<7)
            .compactMap {
                Calendar.current.date(byAdding: .day, value: -$0, to: .now)
            }
            .map {
                .init(value: (0..<2000).randomElement()!, date: $0)
            }
    )
}
