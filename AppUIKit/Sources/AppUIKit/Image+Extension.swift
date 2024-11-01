//
//  Image+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import SwiftUI

public extension Image {
    enum app {
        public enum haptic {
            public static let on = Image(systemName: "iphone.radiowaves.left.and.right.circle.fill")
            public static let off = Image(systemName: "iphone.radiowaves.left.and.right.circle")
        }

        public enum button {
            public static let count = Image(systemName: "suit.heart.fill")
        }

        public enum icon {
            public static let selected = Image(systemName: "checkmark")
            public static let list = Image(systemName: "list.bullet.circle")
            public static let plus = Image(systemName: "plus")
        }
        
        public enum selection {
            public static let on = Image(systemName: "checkmark.circle.fill")
            public static let off = Image(systemName: "circle")
        }
    }
}
