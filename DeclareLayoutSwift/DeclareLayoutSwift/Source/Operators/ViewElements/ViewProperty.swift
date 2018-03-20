//
//  ViewProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/2/8.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum ViewPropertyName {
    case bgColor, cornerRadius
}

public class ViewProperty<TargetPropertyType>: PropertyBase<ViewPropertyName> {
    public static var bgColor: ViewProperty<UIColor?> {
        return ViewProperty<UIColor?>(.bgColor)
    }

    public static var cornerRadius: ViewProperty<CGFloat?> {
        return ViewProperty<CGFloat?>(.cornerRadius)
    }
}

public func <- <TargetType, TargetPropertyType, ViewType>(property: ViewProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: ViewElement<ViewType> {
    let propertyName = property.propertyName
    switch propertyName {
    case .bgColor:
        return PropertySetter<TargetType>(setter: { $0.view.backgroundColor = value as? UIColor })
    case .cornerRadius:
        return PropertySetter<TargetType>(setter: {
            if let cornerRadius = value as? CGFloat {
                $0.view.layer.cornerRadius = cornerRadius
                $0.view.clipsToBounds = true
            } else {
                $0.view.clipsToBounds = false
            }
        })
    }
}

// public func <- <ViewType, TargetPropertyType>(property: ViewProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<ViewElement<ViewType>> where ViewType: UIView {
//    let propertyName = property.propertyName
//    switch propertyName {
//    case .bgColor:
//        return PropertySetter<ViewElement<ViewType>>(setter: { $0.view.backgroundColor = value as? UIColor })
//    case .cornerRadius:
//        return PropertySetter<ViewElement<ViewType>>(setter: {
//            if let cornerRadius = value as? CGFloat {
//                $0.view.layer.cornerRadius = cornerRadius
//                $0.view.clipsToBounds = true
//            } else {
//                $0.view.clipsToBounds = false
//            }
//        })
//    }
// }
