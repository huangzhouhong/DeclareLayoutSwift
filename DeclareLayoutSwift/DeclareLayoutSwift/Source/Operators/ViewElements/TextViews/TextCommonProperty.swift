//
//  TextCommonProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/2/8.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum TextCommonPropertyName {
    case text, textColor, font, fontSize, textAlignment
}

public class TextCommonProperty<TargetPropertyType>: PropertyBase<TextCommonPropertyName> {
    public static var text: TextCommonProperty<String?> {
        return TextCommonProperty<String?>(.text)
    }

    public static var textColor: TextCommonProperty<Any?> {
        return TextCommonProperty<Any?>(.textColor)
    }

    public static var font: TextCommonProperty<UIFont> {
        return TextCommonProperty<UIFont>(.font)
    }

    public static var fontSize: TextCommonProperty<CGFloat> {
        return TextCommonProperty<CGFloat>(.fontSize)
    }

    public static var textAlignment: TextCommonProperty<NSTextAlignment> {
        return TextCommonProperty<NSTextAlignment>(.textAlignment)
    }
}

public func <- <TargetType, TargetPropertyType, ViewType>(property: TextCommonProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: ViewElement<ViewType>, ViewType: UILabel {
    let propertyName = property.propertyName
    switch propertyName {
    case .text:
        return PropertySetter<TargetType>(setter: { $0.view.text = value as? String })
    case .textColor:
        return PropertySetter<TargetType>(setter: { $0.view.textColor = UIColor.parse(value)})
    case .font:
        return PropertySetter<TargetType>(setter: { $0.view.font = value as? UIFont })
    case .fontSize:
        return PropertySetter<TargetType>(setter: { $0.view.font = UIFont.systemFont(ofSize: value as! CGFloat) })
    case .textAlignment:
        return PropertySetter<TargetType>(setter: { $0.view.textAlignment = value as! NSTextAlignment })
    }
}

public func <- <TargetType, TargetPropertyType, ViewType>(property: TextCommonProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: ViewElement<ViewType>, ViewType: UITextField {
    let propertyName = property.propertyName
    switch propertyName {
    case .text:
        return PropertySetter<TargetType>(setter: { $0.view.text = value as? String })
    case .textColor:
        return PropertySetter<TargetType>(setter: { $0.view.textColor = UIColor.parse(value) })
    case .font:
        return PropertySetter<TargetType>(setter: { $0.view.font = value as? UIFont })
    case .fontSize:
        return PropertySetter<TargetType>(setter: { $0.view.font = UIFont.systemFont(ofSize: value as! CGFloat) })
    case .textAlignment:
        return PropertySetter<TargetType>(setter: { $0.view.textAlignment = value as! NSTextAlignment })
    }
}
