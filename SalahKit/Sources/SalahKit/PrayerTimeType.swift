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
            case .fajr: "Fajr"
            case .sunrise: "Sunrise"
            case .dhuhr: "Dhuhr"
            case .asr: "Asr"
            case .sunset: "Sunset"
            case .maghrib: "Maghrib"
            case .isha: "Isha"
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
