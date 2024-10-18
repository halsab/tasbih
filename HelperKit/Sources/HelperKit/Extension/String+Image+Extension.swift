//
//  String+Image+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import Foundation

public extension String {
    enum image {
        public enum haptic {
            public static let on = "iphone.radiowaves.left.and.right.circle.fill"
            public static let off = "iphone.radiowaves.left.and.right.circle"
        }

        public enum button {
            public static let count = "suit.heart.fill"
        }

        public enum icon {
            public static let selected = "checkmark"
        }
    }
}
