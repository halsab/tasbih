//
//  Font+extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import SwiftUI

public extension Font {
    enum app {
        public enum SizeType {
            case xs, s, m, l, xl, xxl, xxxl
            
            var size: Font.TextStyle {
                switch self {
                case .xs: return .subheadline
                case .s: return .callout
                case .m: return .body
                case .l: return .title3
                case .xl: return .title2
                case .xxl: return .title
                case .xxxl: return .largeTitle
                }
            }
        }
        
        public enum WeightType {
            case regular, bold
            
            var wight: Font.Weight {
                switch self {
                case .regular: return .regular
                case .bold: return .bold
                }
            }
        }
        
        public static func font(_ sizeType: SizeType, _ weightType: WeightType = .regular) -> Font {
            .system(sizeType.size, design: .rounded, weight: weightType.wight)
        }
    }
}
