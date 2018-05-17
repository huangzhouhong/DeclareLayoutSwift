//
//  StackPanelProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/2/6.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

public enum StackPanelPropertyName {
    case orientation
}

public class StackPanelProperty<TargetPropertyType>: PropertyBase<StackPanelPropertyName> {
    public static var orientation: StackPanelProperty<StackPanel.Orientation> {
        return StackPanelProperty<StackPanel.Orientation>(.orientation)
    }
}

public func <- <TargetType, TargetPropertyType>(property: StackPanelProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: StackPanel {
    let propertyName = property.propertyName
    switch propertyName {
    case .orientation:
        return PropertySetter<TargetType>(setter: { $0.orientation = value as! StackPanel.Orientation })
    }
}
