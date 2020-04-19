//
//  UIColor+hex.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 10/7/19.
//  Copyright © 2019 arblitroshani. All rights reserved.
//

import UIKit


private extension Int {
    func duplicate4bits() -> Int {
        return (self << 4) + self
    }
}


public extension UIColor {

    var hexString: String {
        guard let components = cgColor.components, components.count >= 3 else {
            return "000000"
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])

        return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }

    convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }

    convenience init?(hexString: String, alpha: Float) {
        var hex = hexString

        if hex.hasPrefix("#") {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
        }

        guard let hexVal = Int(hex, radix: 16) else {
            self.init()
            return nil
        }

        switch hex.count {
        case 0:
            self.init(hexString: "000000")
        case 2:
            self.init(hexString: String(repeating: hex, count: 3), alpha: alpha)
        case 3:
            self.init(hex3: hexVal, alpha: alpha)
        case 6:
            self.init(hex6: hexVal, alpha: alpha)
        default:
            self.init()
            return nil
        }
    }

    /**
     Create non-autoreleased color with in the given hex value. Alpha will be set as 1 by default.

     - parameter hex: The hex value. For example: 0xff8942 (no quotation).
     - returns: A color with the given hex value
     */
    convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }

    /**
     Create non-autoreleased color with in the given hex value and alpha

     - parameter hex: The hex value. For example: 0xff8942 (no quotation).
     - parameter alpha: The alpha value, a floating value between 0 and 1.
     - returns: color with the given hex value and alpha
     */
    convenience init?(hex: Int, alpha: Float) {
        if (0x000000 ... 0xFFFFFF) ~= hex {
            self.init(hex6: hex, alpha: alpha)
        } else {
            self.init()
            return nil
        }
    }

    fileprivate convenience init?(hex3: Int, alpha: Float) {
        self.init(red:   CGFloat( ((hex3 & 0xF00) >> 8).duplicate4bits() ) / 255.0,
                  green: CGFloat( ((hex3 & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
                  blue:  CGFloat( ((hex3 & 0x00F) >> 0).duplicate4bits() ) / 255.0,
                  alpha: CGFloat(alpha))
    }

    fileprivate convenience init?(hex6: Int, alpha: Float) {
        self.init(red:   CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
                  green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
                  blue:  CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0, alpha: CGFloat(alpha))
    }
}
