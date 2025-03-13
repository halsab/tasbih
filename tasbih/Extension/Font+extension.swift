//
//  Font+extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import SwiftUI

extension Font {
    enum app {
        enum SizeType {
            case xxs, xs, s, m, l, xl, xxl
            
            var size: Font.TextStyle {
                switch self {
                case .xxs: .caption2
                case .xs: .caption
                case .s: .subheadline
                case .m: .body
                case .l: .title3
                case .xl: .title
                case .xxl: .largeTitle
                }
            }
        }
        
        enum WeightType {
            case regular, bold, semibold
            
            var value: Font.Weight {
                switch self {
                case .regular: .regular
                case .semibold: .semibold
                case .bold: .bold
                }
            }
        }
        
        static func font(_ sizeType: SizeType, weight: WeightType = .regular) -> Font {
            switch sizeType {
            case .xxs: .system(size: 14, weight: weight.value)
            default: .system(sizeType.size, design: .rounded, weight: weight.value)
            }
        }
    }
}
