//
//  PrayerTimeType.swift
//  tasbih
//
//  Created by Khalil Sabirov on 07.10.2024.
//

import Foundation

enum PrayerTimeType {
    case fajr
    case sunrise
    case dhuhr
    case asr
    case sunset
    case maghrib
    case isha
    
    func name(_ language: Language = .english) -> String {
        switch language {
        case .english:
            switch self {
            case .fajr: "fajr"
            case .sunrise: "sunrise"
            case .dhuhr: "dhuhr"
            case .asr: "asr"
            case .sunset: "sunset"
            case .maghrib: "maghrib"
            case .isha: "isha"
            }
        case .russian:
            switch self {
            case .fajr: "Фаджр"
            case .sunrise: "Восход"
            case .dhuhr: "Зухр"
            case .asr: "Аср"
            case .sunset: "Закат"
            case .maghrib: "Магриб"
            case .isha: "Иша"
            }
        }
    }
    
    enum Language {
        case english, russian
    }
}
