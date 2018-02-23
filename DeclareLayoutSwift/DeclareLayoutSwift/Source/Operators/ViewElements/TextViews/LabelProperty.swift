//
//  LabelProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/30.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum LabelPropertyName {
    case numberOfLines
}

public class LabelProperty<TargetPropertyType>: PropertyBase<LabelPropertyName> {
    public static var numberOfLines: LabelProperty<Int> {
        return LabelProperty<Int>(.numberOfLines)
    }
}

public func <- <TargetType, TargetPropertyType>(property: LabelProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: Label {
    let propertyName = property.propertyName
    switch propertyName {
    case .numberOfLines:
        return PropertySetter<TargetType>(setter: { $0.view.numberOfLines = value as! Int })
    }
}
// enum LabelPropertyName {
//    case text, numberOfLines, textColor
// }
//
// class LabelProperty<TargetPropertyType>: PropertyBase<LabelPropertyName> {
//    static var text: LabelProperty<String?> {
//        return LabelProperty<String?>(.text)
//    }
//    static var numberOfLines: LabelProperty<Int> {
//        return LabelProperty<Int>(.numberOfLines)
//    }
//    static var textColor: LabelProperty<UIColor?> {
//        return LabelProperty<UIColor?>(.textColor)
//    }
// }
//
// func <- <TargetType, TargetPropertyType>(property: LabelProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: Label {
//    let propertyName = property.propertyName
//    switch propertyName {
//    case .text:
//        return PropertySetter<TargetType>(setter: { $0.view.text = value as? String })
//    case .numberOfLines:
//        return PropertySetter<TargetType>(setter: { $0.view.numberOfLines = value as! Int })
//    case .textColor:
//        return PropertySetter<TargetType>(setter: { $0.view.textColor = value as? UIColor })
//    }
// }
