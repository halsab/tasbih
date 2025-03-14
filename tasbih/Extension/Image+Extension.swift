//
//  Image+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import SwiftUI

extension Image {    
    enum app {
        enum haptic {
            static let on = Image(systemName: "iphone.radiowaves.left.and.right.circle.fill")
            static let off = Image(systemName: "iphone.radiowaves.left.and.right.circle")
        }

        enum button {
            static let count = Image(systemName: "suit.heart.fill")
            static let increase = Image(systemName: "plus.circle")
            static let book = Image(systemName: "book")
            static let create = Image(systemName: "plus.circle.fill")
        }
        
        enum swipe {
            static let delete = Image(systemName: "trash.fill")
            static let select = Image(systemName: "checkmark.circle.fill")
        }

        enum icon {
            static let selected = Image(systemName: "checkmark")
            static let list = Image(systemName: "list.bullet.circle")
            static let plus = Image(systemName: "plus")
            static let location = Image(systemName: "location.circle")
            static let settings = Image(systemName: "gearshape")
        }
        
        enum selection {
            static let on = Image(systemName: "checkmark.circle.fill")
            static let off = Image(systemName: "circle")
        }
        
        enum tab {
            static let zikr = Image(systemName: "aqi.medium")
            static let salah = Image(systemName: "moon")
        }
        
        enum infoHeader {
            static let zikrs = Image(systemName: "heart.square.fill")
        }
    }
}
