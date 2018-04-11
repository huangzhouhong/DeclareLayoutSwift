//
//  UIColor+Parse.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/14.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public extension UIColor {
    public convenience init(rgbValue: Int) {
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public convenience init(colorString: String) {
        var cString: String = colorString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(rgbValue: Int(rgbValue))
    }
    
    public static func parse(_ obj: Any?) -> UIColor? {
        if let color = obj as? UIColor {
            return color
        } else if let colorString = obj as? String {
            return UIColor(colorString: colorString)
        } else if let colorValue = obj as? Int {
            return UIColor(rgbValue: colorValue)
        } else {
            return nil
        }
    }
}
