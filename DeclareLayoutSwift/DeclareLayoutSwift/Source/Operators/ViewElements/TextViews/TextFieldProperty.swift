//
//  TextFieldProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/2/6.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

//enum TextFieldPropertyName {
//    case text
//}
//
//class TextFieldProperty<TargetPropertyType>: PropertyBase<TextFieldPropertyName> {
//    static var text: TextFieldProperty<String?> {
//        return TextFieldProperty<String?>(.text)
//    }
//}
//
//func <- <TargetType, TargetPropertyType>(property: TextFieldProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: TextField {
//    let propertyName = property.propertyName
//    switch propertyName {
//    case .text:
//        return PropertySetter<TargetType>(setter: { $0.view.text = value as? String })
//    }
//}

