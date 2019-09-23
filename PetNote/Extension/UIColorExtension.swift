//
//  UIColorExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/9/22.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

private enum PNColor: String {

    case PNDarkPink

    case turkyBlue = "33e6cc"

    case lightBlue = "E0ffff"

    case dodgerBule = "1E90FF"

    case darkYellow = "705214"
    
    case PNWhite
    
    case PNDarkBlue
    
    case PNLightBlue
    
    case PNGray
    
    case PNPink
    
}

extension UIColor {
    
    static let pnDarkPink = PNColor(.PNDarkPink) // 珊瑚橘
    static let darkYellow = PNColor(.darkYellow) 
    
    static let turkyBlue = PNColor(.turkyBlue)
    static let lightBlue = PNColor(.lightBlue)
    static let dodgerBule = PNColor(.dodgerBule)
    
    static let pnWhite = PNColor(.PNWhite) // 珊瑚橘
    static let pnPink = PNColor(.PNPink)
    
    static let pnGray = PNColor(.PNGray)
    static let pnBlueLight = PNColor(.PNLightBlue)
    static let pnBlueDark = PNColor(.PNDarkBlue)
    
    private static func PNColor(_ color: PNColor) -> UIColor? {
      
        guard
            let resultColor = UIColor(named: color.rawValue)
        else {
            return hexStringToUIColor(hex: color.rawValue)
        }
        
        return resultColor
    }
    
    static func hexStringToUIColor(hex: String) -> UIColor {

        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
