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
            static let haptic = "common-isHapticEnabled-key"
            static let selectedTab = "common-selectedTab-key"
            static let appScheme = "common-appScheme-key"
        }
        
        enum zikr {
            static let selectedZikrName = "zikr-selectedZikrName-key"
        }
        
        enum dua {
            static let isArabicVisible = "dua-isArabicVisible-key"
            static let isTranslationVisible = "dua-isTranslationVisible-key"
            static let isTranscriptionVisible = "dua-isTranscriptionVisible-key"
        }
        
        enum salah {
            static let calculationMethod = "salah-calculationMethod-key"
            static let lastLatitude = "salah-lastLatitude-key"
            static let lastLongitude = "salah-lastLongitude-key"
        }
    }
}
