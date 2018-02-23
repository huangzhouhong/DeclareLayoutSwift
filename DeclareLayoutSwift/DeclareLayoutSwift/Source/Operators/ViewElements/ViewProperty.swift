//
//  ViewProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/2/8.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum ViewPropertyName {
    case bgColor
}

public class ViewProperty<TargetPropertyType>: PropertyBase<ViewPropertyName> {
    public static var bgColor: ViewProperty<UIColor?> {
        return ViewProperty<UIColor?>(.bgColor)
    }
}

public func <- <ViewType, TargetPropertyType>(property: ViewProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<ViewElement<ViewType>> where ViewType: UIView {
    let propertyName = property.propertyName
    switch propertyName {
    case .bgColor:
        return PropertySetter<ViewElement<ViewType>>(setter: { $0.view.backgroundColor = value as? UIColor })
    }
}

