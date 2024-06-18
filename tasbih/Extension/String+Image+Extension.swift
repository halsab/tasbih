//
//  String+Image+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import Foundation

extension String {
    enum image {
        enum haptic {
            static let on = "iphone.radiowaves.left.and.right.circle.fill"
            static let off = "iphone.radiowaves.left.and.right.circle"
        }

        enum sound {
            static let on = "speaker.wave.2.circle.fill"
            static let off = "speaker.wave.2.circle"
        }

        enum button {
            static let count = "suit.heart.fill"
        }

        enum icon {
            static let selected = "checkmark"
        }
    }
}
