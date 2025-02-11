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
            case s, m, l, xl, xxl
            
            var size: Font.TextStyle {
                switch self {
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
            .system(sizeType.size, design: .rounded, weight: weight.value)
        }
    }
}
