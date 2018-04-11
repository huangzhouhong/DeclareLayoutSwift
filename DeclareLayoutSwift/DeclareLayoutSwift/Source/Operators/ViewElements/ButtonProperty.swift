//
//  ButtonProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/30.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum ButtonPropertyName {
    case image, text, textColor, font, fontSize, textAlignment
}

public class ButtonProperty<TargetPropertyType>: PropertyBase<ButtonPropertyName> {
    public static var title: ButtonProperty<String?> {
        return text
    }
    
    // `Any` since support multiple type
    public static var image: ButtonProperty<Any?> {
        return ButtonProperty<Any?>(.image)
    }

    public static var text: ButtonProperty<String?> {
        return ButtonProperty<String?>(.text)
    }

    public static var textColor: ButtonProperty<Any?> {
        return ButtonProperty<Any?>(.textColor)
    }

    public static var font: ButtonProperty<UIFont> {
        return ButtonProperty<UIFont>(.font)
    }

    public static var fontSize: ButtonProperty<CGFloat> {
        return ButtonProperty<CGFloat>(.fontSize)
    }

    public static var textAlignment: ButtonProperty<UIControlContentHorizontalAlignment> {
        return ButtonProperty<UIControlContentHorizontalAlignment>(.textAlignment)
    }
}

public func <- <TargetType, TargetPropertyType, ViewType>(property: ButtonProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: ViewElement<ViewType>, ViewType: UIButton {
    let propertyName = property.propertyName
    switch propertyName {
    case .text:
        return PropertySetter<TargetType>(setter: { $0.view.setTitle(value as? String, for: .normal) })
    case .textColor:
        return PropertySetter<TargetType>(setter: { $0.view.setTitleColor(UIColor.parse(value), for: .normal) })
    case .font:
        return PropertySetter<TargetType>(setter: { $0.view.titleLabel?.font = value as? UIFont })
    case .fontSize:
        return PropertySetter<TargetType>(setter: { $0.view.titleLabel?.font = UIFont.systemFont(ofSize: value as! CGFloat) })
    case .textAlignment:
        return PropertySetter<TargetType>(setter: { $0.view.contentHorizontalAlignment = value as! UIControlContentHorizontalAlignment })
    case .image:
        return PropertySetter<TargetType>(setter: {
            if let string = value as? String {
                $0.view.setImage(UIImage(named: string), for: .normal)
            } else {
                $0.view.setImage(value as? UIImage, for: .normal)
            }
        })
    }

}
