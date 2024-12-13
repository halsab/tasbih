//
//  Math.swift
//  tasbih
//
//  Created by Khalil Sabirov on 05.10.2024.
//

import Foundation

enum Math {
    static func wrap(_ number: Double, min: Double, max: Double) -> Double {
        let range = max - min
        var result = number
        if result < min { result += range }
        if result > max { result -= range }
        return result
    }
    
    /// range reduce angle in degrees.
    static func fixAngle(_ angle: Double) -> Double {
        wrap(angle, min: 0, max: 360)
    }
    
    /// degree sin
    static func dSin(_ degree: Double) -> Double {
        sin(degreesToRadians(degree))
    }
    
    /// degree cos
    static func dCos(_ degree: Double) -> Double {
        cos(degreesToRadians(degree))
    }
    
    /// degree tan
    static func dTan(_ degree: Double) -> Double {
        tan(degreesToRadians(degree))
    }
    
    /// degree arcsin
    static func dArcSin(_ x: Double) -> Double {
        radiansToDegrees(asin(x))
    }
    
    /// degree arccos
    static func dArcCos(_ x: Double) -> Double {
        radiansToDegrees(acos(x))
    }
    
    /// degree arctan2
    static func dArcTan2(_ y: Double, x: Double) -> Double {
        radiansToDegrees(atan2(y, x))
    }
    
    /// degree arccot
    static func dArcCot(_ x: Double) -> Double {
        radiansToDegrees(atan2(1.0, x))
    }
    
    /// radian to degree
    private static func radiansToDegrees(_ alpha: Double) -> Double {
        alpha * 180 / .pi
    }
    
    /// deree to radian
    private static func degreesToRadians(_ alpha: Double) -> Double {
        alpha * .pi / 180
    }
}
