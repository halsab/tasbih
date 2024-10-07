//
//  String+AppStorage+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import Foundation

extension String {
    enum storageKey {
        enum common {
            static let haptic = "isHapticEnabled"
            static let sound = "isSoundEnabled"
            static let selectedTab = "selectedTab-key"
        }
        
        enum vird {
            static let book = "vird-book-key"
            static let tafsir = "vird-tafsir-key"
            static let quran = "vird-quran-key"
            static let zikr = "vird-zikr-key"
            static let uraza = "vird-uraza-key"
            static let tahadjud = "vird-tahadjud-key"
            static let ishrak = "vird-ishrak-key"
            static let duha = "vird-duha-key"
            static let avvabin = "vird-avvabin-key"
            static let shukurVudu = "vird-shukurVudu-key"
            static let quranAfterNamaz = "vird-quranAfterNamaz-key"
        }
    }
}
