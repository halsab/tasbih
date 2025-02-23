//
//  Date+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 20.02.2025.
//

import Foundation

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isInThisWeek: Bool {
        Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    var isInThisMonth: Bool {
        Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }
    
    var isInThisYear: Bool {
        Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
    var dayNumber: Int {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        return day
    }
    
    var weekNumber: Int {
        let calendar = Calendar.current
        let week = calendar.component(.weekOfYear, from: self)
        return week
    }
    
    var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }
    
    var yearNumber: Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return year
    }
}
