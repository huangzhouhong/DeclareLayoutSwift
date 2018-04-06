//
//  LayoutblePropertyName.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/29.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum LayoutablePropertyName {
    case horizontalAlignment, verticalAlignment, width, height, margin, padding, visibility, gridRowIndex, gridColumnIndex, context
}

public class LayoutableProperty<TargetPropertyType>: PropertyBase<LayoutablePropertyName> {
    public static var horizontalAlignment: LayoutableProperty<HorizontalAlignment?> {
        return LayoutableProperty<HorizontalAlignment?>(.horizontalAlignment)
    }
    public static var verticalAlignment: LayoutableProperty<VerticalAlignment?> {
        return LayoutableProperty<VerticalAlignment?>(.verticalAlignment)
    }
    public static var width: LayoutableProperty<CGFloat?> {
        return LayoutableProperty<CGFloat?>(.width)
    }
    public static var height: LayoutableProperty<CGFloat?> {
        return LayoutableProperty<CGFloat?>(.height)
    }
    public static var margin: LayoutableProperty<UIEdgeInsets?> {
        return LayoutableProperty<UIEdgeInsets?>(.margin)
    }
    public static var padding: LayoutableProperty<UIEdgeInsets?> {
        return LayoutableProperty<UIEdgeInsets?>(.padding)
    }
    public static var visibility: LayoutableProperty<Visibility> {
        return LayoutableProperty<Visibility>(.visibility)
    }
    public static var gridRowIndex: LayoutableProperty<Int> {
        return LayoutableProperty<Int>(.gridRowIndex)
    }
    public static var gridColumnIndex: LayoutableProperty<Int> {
        return LayoutableProperty<Int>(.gridColumnIndex)
    }
    public static var context: LayoutableProperty<AnyObject> {
        return LayoutableProperty<AnyObject>(.context)
    }

    // for short
    public static var hAlign: LayoutableProperty<HorizontalAlignment?> {
        return horizontalAlignment
    }
    public static var vAlign: LayoutableProperty<VerticalAlignment?> {
        return verticalAlignment
    }
}

public func <- <TargetType, TargetPropertyType>(property: LayoutableProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: Layoutable {
    let propertyName = property.propertyName
    switch propertyName {
    case .horizontalAlignment:
        return PropertySetter<TargetType>(setter: { $0.horizontalAlignment = value as? HorizontalAlignment })
    case .verticalAlignment:
        return PropertySetter<TargetType>(setter: { $0.verticalAlignment = value as? VerticalAlignment })
    case .width:
        return PropertySetter<TargetType>(setter: { $0.width = value as? CGFloat })
    case .height:
        return PropertySetter<TargetType>(setter: { $0.height = value as? CGFloat })
    case .margin:
        return PropertySetter<TargetType>(setter: { $0.margin = value as? UIEdgeInsets })
    case .padding:
        return PropertySetter<TargetType>(setter: { $0.padding = value as? UIEdgeInsets })
    case .gridRowIndex:
        return PropertySetter<TargetType>(setter: { Grid.setRow(ele: $0, row: value as! Int) })
    case .gridColumnIndex:
        return PropertySetter<TargetType>(setter: { Grid.setColumn(ele: $0, column: value as! Int) })
    case .visibility:
        return PropertySetter<TargetType>(setter: { $0.visibility = value as! Visibility })
    case .context:
        return PropertySetter<TargetType>(setter: { $0.context = value as AnyObject  })
    }
}
