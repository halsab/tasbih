//
//  Calendar+Extension.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import Foundation

extension Calendar {
    static var user: () -> Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = .init(identifier: "en_EN")
        calendar.firstWeekday = 1
        return calendar
    }
    
    func weekdays(for date: Date = Date()) -> [Date] {
        let dayOfWeek = component(.weekday, from: date) - 1
        guard let range = range(of: .weekday, in: .weekOfYear, for: date) else { return [] }
        return range
            .compactMap { self.date(byAdding: .day, value: $0 - dayOfWeek, to: date) }
    }
    
    func monthdays(for date: Date = Date()) -> [Date] {
        let dayOfMonth = component(.day, from: date)
        guard let range = range(of: .day, in: .month, for: date) else { return [] }
        return range.compactMap {
            self.date(byAdding: .day, value: $0 - dayOfMonth, to: date)
        }
    }
    
    func filledMonthdays(for date: Date = Date()) -> [Date] {
        var days = monthdays(for: date)
        if let firstMonthday = days.first {
            let firstMonthdayNumber = component(.weekday, from: firstMonthday)
            guard firstMonthdayNumber > 0 else { return days }
            let head = (1..<firstMonthdayNumber)
                .compactMap { self.date(byAdding: .day, value: -$0, to: firstMonthday) }
                .reversed()
            days.insert(contentsOf: Array(head), at: 0)
        }
        if let lastMonthday = days.last {
            let lastMonthdayNumber = component(.weekday, from: lastMonthday)
            guard lastMonthdayNumber < 7 else { return days }
            let tail = (1..<7 - lastMonthdayNumber + 1)
                .compactMap { self.date(byAdding: .day, value: $0, to: lastMonthday) }
            days.append(contentsOf: tail)
        }
        return days
    }
}
