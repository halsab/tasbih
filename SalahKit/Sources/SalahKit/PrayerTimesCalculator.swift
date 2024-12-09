//
//  PrayerTimesCalculator.swift
//  tasbih
//
//  Created by Khalil Sabirov on 04.10.2024.
//

import Foundation
import CoreLocation

final class PrayerTimesCalculator {
    
    private let gregorianCalendar = Calendar(identifier: .gregorian)
    private let method: Method
    
    /// Coordinate of the place, times will be calculated for.
    private var coordinate: CLLocationCoordinate2D {
        didSet {
            calculateJulianDate()
        }
    }
    
    /// Date for which prayer times will be calculated. Defaults to today, when not set.
    private var calcDate: Date {
        didSet {
            calculateJulianDate()
        }
    }
    
    /// Timezone of the place, times will be calculated for.
    private lazy var timeZone = systemTimeZone()
    private lazy var jDate = julianDate(from: calcDate)
    private lazy var prayerTimes = makeDefaultPrayerTimes()
    
    // MARK: Init
    
    init(coordinate: CLLocationCoordinate2D, date: Date = .now, method: Method = .dumRT) {
        self.coordinate = coordinate
//        self.coordinate = .init(latitude: 21.42052379343408, longitude: 39.820214260512685) // Makkah
//        self.coordinate = .init(latitude: 36.893429351303325, longitude: 30.71133912270379) // Antalya
//        self.coordinate = .init(latitude: 55.7887, longitude: 49.1221) // Kazan
        calcDate = date
        self.method = method
    }
    
    private static let defaultTimeTypes: [PrayerTimeType] = [
        .fajr,
        .sunrise,
        .dhuhr,
        .asr,
        .maghrib,
        .isha
    ]
}

// MARK: - Public Methods

extension PrayerTimesCalculator {    
    func prayerTimes(
        coordinate: CLLocationCoordinate2D? = nil,
        date: Date = .now,
        timeTypes: [PrayerTimeType] = PrayerTimesCalculator.defaultTimeTypes
    ) -> [PrayerTime] {
        reset()
        if let coordinate {
            self.coordinate = coordinate
        }
        calcDate = date
        computeDayTimes()
        return filtered(times: prayerTimes, by: timeTypes)
    }
}

// MARK: - Helpers

private extension PrayerTimesCalculator {
    func makeDefaultPrayerTimes() -> [PrayerTime] {
        [
            .init(type: .fajr, dateNumeric: 3),
            .init(type: .sunrise, dateNumeric: 6),
            .init(type: .dhuhr, dateNumeric: 12),
            .init(type: .asr, dateNumeric: 15),
            .init(type: .sunset, dateNumeric: 18),
            .init(type: .maghrib, dateNumeric: 18),
            .init(type: .isha, dateNumeric: 21),
        ]
    }
    
    func reset() {
        prayerTimes = makeDefaultPrayerTimes()
    }
    
    func filtered(times: [PrayerTime], by types: [PrayerTimeType]) -> [PrayerTime] {
        times.filter { types.contains($0.type) }
    }
}

// MARK: - Convertion Methods

private extension PrayerTimesCalculator {
    /// Convert float hours to (hours, minutes)
    func floatToHourMinute(_ time: Double) -> (hours: Int, minutes: Int)? {
        if time.isNaN {
            return nil
        }
        
        let ttime = fixHour(time + 0.5 / 60.0)  // add 0.5 minutes to round
        let hours = Int(floor(time))
        let minutes = Int(floor((ttime - Double(hours)) * 60.0))
        
        return (hours: hours, minutes: minutes)
    }
    
    /// Convert float hours to NSDate
    func floatToDate(_ time: Double) -> Date? {
        if let (hours, minutes) = floatToHourMinute(time) {
            var components = gregorianCalendar.dateComponents([.hour, .minute, .day, .year, .month], from: calcDate)
            components.hour = hours
            components.minute = minutes
            guard var date = gregorianCalendar.date(from: components) else { return nil }
            let recalculatedComponents = gregorianCalendar.dateComponents([.hour, .minute], from: date)
            components.hour = recalculatedComponents.hour
            components.minute = recalculatedComponents.minute
            date = gregorianCalendar.date(from: components)!
            return date
        } else {
            return nil
        }
    }
}

// MARK: - Julian Date Calculation

private extension PrayerTimesCalculator {
    func calculateJulianDate() {
        jDate = julianDate(from: calcDate)
        jDate = jDate - (coordinate.longitude / (15.0 * 24.0))
    }
    
    func julianDate(from date: Date) -> Double {
        let components = gregorianCalendar.dateComponents([.year, .month, .day], from: date)
        return julianDate(
            year: components.year ?? 0,
            month: components.month ?? 0,
            day: components.day ?? 0
        )
    }
    
    func julianDate(year: Int, month: Int, day: Int) -> Double {
        var yyear = year, mmonth = month, dday = day
        
        if mmonth < 2 {
            yyear -= 1
            mmonth += 12
        }
        
        let A = floor(Double(yyear) / 100)
        let B = 2 - A + floor(A / 4)
        
        return floor(365.25 * (Double(yyear) + 4716.0))
        + floor(30.6001 * (Double(mmonth) + 1.0))
        + Double(dday) + B - 1524.5
    }
}

// MARK: - Compute Time and Date

private extension PrayerTimesCalculator {
    /// compute the difference between two times
    func timeDiff(_ time1: Double, time2: Double) -> Double {
        fixHour(time2 - time1)
    }
    
    /// compute declination angle of sun and equation of time
    func sunPosition(_ jd: Double) -> (Double, Double) {
        let D = jd - 2451545.0
        let g = Math.fixAngle(357.529 + 0.98560028 * D)
        let q = Math.fixAngle(280.459 + 0.98564736 * D)
        let L = Math.fixAngle(q + (1.915 * Math.dSin(g)) + (0.020 * Math.dSin(2 * g)))
        
        let e = 23.439 - (0.00000036 * D)
        var RA = Math.dArcTan2(Math.dCos(e) * Math.dSin(L), x: Math.dCos(L)) / 15.0
        RA = fixHour(RA)
        
        let d = Math.dArcSin(Math.dSin(e) * Math.dSin(L))
        let EqT = q / 15.0 - RA
        
        return (d, EqT)
    }
    
    /// compute equation of time
    func equationOfTime(_ jd: Double) -> Double {
        let (_, EqT) = sunPosition(jd)
        return EqT
    }
    
    /// compute declination angle of sun
    func sunDeclination(_ jd: Double) -> Double {
        let (d, _) = sunPosition(jd)
        return d
    }
    
    /// compute mid-day (Dhuhr, Zawal) time
    func computeMidDay(_ t: Double) -> Double {
        let T = equationOfTime(jDate + t)
        return fixHour(12 - T)
    }
    
    /// compute time for a given angle G
    func computeTime(_ G: Double, t: Double) -> Double {
        let D = sunDeclination(jDate + t)
        let Z = computeMidDay(t)
        let V = Math.dArcCos(
            (-Math.dSin(G) - (Math.dSin(D) * Math.dSin(coordinate.latitude)))
            / (Math.dCos(D) * Math.dCos(coordinate.latitude))
        ) / 15.0
        
        if G > 90 {
            return Z - V
        } else {
            return Z + V
        }
    }
    
    /// compute the time of Asr; Hanafi: step = 2
    func computeAsr(step: Double, t: Double) -> Double {
        let d = sunDeclination(jDate + t)
        let g = -Math.dArcCot(step + Math.dTan(abs(coordinate.latitude - d)))
        return computeTime(g, t: t)
    }
    
    func systemTimeZone() -> Float {
        let timeZone = TimeZone.current
        return Float(timeZone.secondsFromGMT()) / 3600
    }
}

// MARK: - Compute Prayer Times

private extension PrayerTimesCalculator {
    /// compute prayer times at given julian date
    func computeTimes(_ times: [PrayerTime]) {
        for time in times {
            
            // convert hours to day portions
            time.dateNumeric = time.dateNumeric / 24
            
            switch time.type {
            case .fajr:
                time.dateNumeric = computeTime((180.0 - method.fajrAngle), t: time.dateNumeric)
            case .sunrise:
                time.dateNumeric = computeTime((180.0 - 0.833), t: time.dateNumeric)
            case .dhuhr:
                time.dateNumeric = computeMidDay(time.dateNumeric)
            case .asr:
                time.dateNumeric = computeAsr(step: method.asrParameter, t: time.dateNumeric)
            case .sunset:
                time.dateNumeric = computeTime(0.833, t: time.dateNumeric)
            case .maghrib:
                time.dateNumeric = computeTime(method.maghribParameter, t: time.dateNumeric)
            case .isha:
                time.dateNumeric = computeTime(method.ishaParameter, t: time.dateNumeric)
            }
        }
    }
    
    func computeDayTimes() {
        computeTimes(prayerTimes)
        adjustTimes(prayerTimes)
        prayerTimes.forEach { $0.date = floatToDate($0.dateNumeric) ?? .now }
    }
    
    /// range reduce hours to 0..23
    func fixHour(_ a: Double) -> Double {
        Math.wrap(a, min: 0, max: 24)
    }
    
    /// adjust times in a prayer time array
    func adjustTimes(_ times: [PrayerTime]) {
        for time in times {
            time.dateNumeric = time.dateNumeric + (Double(timeZone) - coordinate.longitude / 15.0)
            
            switch time.type {
            case .maghrib:
                if method.maghribSelector == 1,
                   let sunsetValue = times.first(where: { $0.type == .sunset})?.dateNumeric {
                    time.dateNumeric = sunsetValue + method.maghribParameter / 60.0
                }
            case .isha:
                if method.ishaSelector == 1,
                   let maghribValue = times.first(where: { $0.type == .sunset})?.dateNumeric {
                    time.dateNumeric = maghribValue + method.ishaParameter / 60.0
                }
            default:
                break
            }
        }
        
        adjustHighLatTimes(times)
    }
    
    /// adjust Fajr, Isha and Maghrib for locations in higher latitudes
    func adjustHighLatTimes(_ times: [PrayerTime]) {
        guard let sunsetValue = times.first(where: { $0.type == .sunset})?.dateNumeric,
              let sunriseValue = times.first(where: { $0.type == .sunrise})?.dateNumeric else {
            return
        }
        
        let nightTime = timeDiff(sunsetValue, time2: sunriseValue) // sunset to sunrise
        
        for time in times {
            switch time.type {
            case .fajr:
                let fajrDiff = nightPortion(angle: method.fajrAngle) * nightTime
                if time.dateNumeric.isNaN || timeDiff(time.dateNumeric, time2: sunriseValue) > fajrDiff {
                    time.dateNumeric = sunriseValue - fajrDiff
                }
            case .maghrib:
                let maghribAngle = method.maghribSelector == 0 ? method.maghribParameter : 4
                let maghribDiff = nightPortion(angle: maghribAngle) * nightTime
                if time.dateNumeric.isNaN || timeDiff(sunsetValue, time2: time.dateNumeric) > maghribDiff {
                    time.dateNumeric = sunsetValue + maghribDiff
                }
            case .isha:
                let ishaAngle = method.ishaSelector == 0 ? method.ishaParameter : 18
                let ishaDiff = nightPortion(angle: ishaAngle) * nightTime
                if time.dateNumeric.isNaN || timeDiff(sunsetValue, time2: time.dateNumeric) > ishaDiff {
                    time.dateNumeric = sunsetValue + ishaDiff
                }
            default:
                break
            }
        }
    }
    
    /// the night portion used for adjusting times in higher latitudes
    func nightPortion(angle: Double) -> Double {
        angle / 60.0
    }
}

// MARK: - Method

extension PrayerTimesCalculator {
    enum Method: String, CaseIterable, Hashable, Identifiable {
        case dumRT
        case dumRF
        case ummAlQura
        case turkeyDiyanet
        
        var id: Self { self }
        
        var name: String {
            switch self {
            case .dumRT: "Dum RT"
            case .dumRF: "Dum RF"
            case .ummAlQura: "Umm Al-Qura"
            case .turkeyDiyanet: "Turkey Diyanet"
            }
        }
        
        /// fajr angle
        var fajrAngle: Double {
            switch self {
            case .dumRT: 18
            case .dumRF: 16
            case .ummAlQura: 18.5
            case .turkeyDiyanet: 18
            }
        }
        
        /// maghrib selector (0 = angle; 1 = minutes after sunset)
        var maghribSelector: Double {
            switch self {
            case .dumRT: 0
            case .dumRF: 1
            case .ummAlQura: 1
            case .turkeyDiyanet: 1
            }
        }
        
        /// maghrib parameter value (in angle or minutes)
        var maghribParameter: Double {
            switch self {
            case .dumRT: 1
            case .dumRF: 1
            case .ummAlQura: 1
            case .turkeyDiyanet: 1
            }
        }
        
        /// isha selector (0 = angle; 1 = minutes after maghrib)
        var ishaSelector: Double {
            switch self {
            case .dumRT: 0
            case .dumRF: 0
            case .ummAlQura: 1
            case .turkeyDiyanet: 0
            }
        }
        
        /// isha parameter value (in angle or minutes)
        var ishaParameter: Double {
            switch self {
            case .dumRT: 15
            case .dumRF: 15
            case .ummAlQura: 90
            case .turkeyDiyanet: 17
            }
        }
        
        var asrParameter: Double {
            switch self {
            case .dumRT: 2
            case .dumRF: 1
            case .ummAlQura: 1
            case .turkeyDiyanet: 1
            }
        }
    }
}
