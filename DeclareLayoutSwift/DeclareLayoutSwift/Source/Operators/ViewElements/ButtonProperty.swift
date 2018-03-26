//
//  ButtonProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/30.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum ButtonPropertyName {
    case title, image
}

public class ButtonProperty<TargetPropertyType>: PropertyBase<ButtonPropertyName> {
    public static var title: ButtonProperty<String?> {
        return ButtonProperty<String?>(.title)
    }
    // `Any` since support multiple type
    public static var image: ButtonProperty<Any?> {
        return ButtonProperty<Any?>(.image)
    }
}

public func <- <TargetType, TargetPropertyType>(property: ButtonProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: Button {
    let propertyName = property.propertyName
    switch propertyName {
    case .title:
        return PropertySetter<TargetType>(setter: { $0.view.setTitle(value as? String, for: .normal) })
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
