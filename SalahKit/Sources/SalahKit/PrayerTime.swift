//
//  PrayerTime.swift
//  tasbih
//
//  Created by Khalil Sabirov on 07.10.2024.
//

import Foundation

final class PrayerTime: Identifiable {
    let id = UUID()
    let type: PrayerTimeType
    var date: Date
    var dateNumeric: Double
    
    init(type: PrayerTimeType, dateNumeric: Double = 12) {
        self.type = type
        self.date = .now
        self.dateNumeric = dateNumeric
    }
}
