//
//  TableProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/30.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//
import UIKit

public enum TablePropertyName {
    case delegate
}

public class TableProperty<TargetPropertyType>: PropertyBase<TablePropertyName> {
    public static var delegate: TableProperty<TableElementDelegate> {
        return TableProperty<TableElementDelegate>(.delegate)
    }
}

public func <- <TargetType, TargetPropertyType>(property: TableProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: TableElement {
    let propertyName = property.propertyName
    switch propertyName {
    case .delegate:
        return PropertySetter<TargetType>(setter: { $0.delegate = value as? TableElementDelegate })
    }
}
