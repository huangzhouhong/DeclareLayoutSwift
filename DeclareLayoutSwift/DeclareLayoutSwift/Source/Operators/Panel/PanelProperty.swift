//
//  PanelProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/10.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

public enum PanelPropertyName {
    case children
}

public class PanelProperty<TargetPropertyType>: PropertyBase<PanelPropertyName> {
    public static var children: PanelProperty<[Layoutable]> {
        return PanelProperty<[Layoutable]>(.children)
    }
    
}

public func <- <TargetType, TargetPropertyType>(property: PanelProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: Panel {
    let propertyName = property.propertyName
    switch propertyName {
    case .children:
        return PropertySetter<TargetType>(setter: { $0.children = value as! [Layoutable] })
    }
}
