//
//  ButtonProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/30.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum ButtonPropertyName {
    case title
}

public class ButtonProperty<TargetPropertyType>: PropertyBase<ButtonPropertyName> {
    public static var title: ButtonProperty<String?> {
        return ButtonProperty<String?>(.title)
    }
}

public func <- <TargetType, TargetPropertyType>(property: ButtonProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: Button {
    let propertyName = property.propertyName
    switch propertyName {
    case .title:
        return PropertySetter<TargetType>(setter: { $0.view.setTitle(value as? String, for: .normal) })
    }
}
