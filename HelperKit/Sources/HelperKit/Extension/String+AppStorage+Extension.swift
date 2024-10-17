//
//  String+AppStorage+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import Foundation

public extension String {
    enum storageKey {
        public enum common {
            public static let haptic = "isHapticEnabled"
            public static let sound = "isSoundEnabled"
            public static let selectedTab = "selectedTab-key"
        }
        
        public enum vird {
            public static let book = "vird-book-key"
            public static let tafsir = "vird-tafsir-key"
            public static let quran = "vird-quran-key"
            public static let zikr = "vird-zikr-key"
            public static let uraza = "vird-uraza-key"
            public static let tahadjud = "vird-tahadjud-key"
            public static let ishrak = "vird-ishrak-key"
            public static let duha = "vird-duha-key"
            public static let avvabin = "vird-avvabin-key"
            public static let shukurVudu = "vird-shukurVudu-key"
            public static let quranAfterNamaz = "vird-quranAfterNamaz-key"
        }
    }
}
