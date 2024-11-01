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
            public static let haptic = "common-isHapticEnabled-key"
            public static let selectedTab = "common-selectedTab-key"
        }
        
        public enum zikr {
            public static let selectedZikrName = "zikr-selectedZikrName-key"
        }
    }
}
