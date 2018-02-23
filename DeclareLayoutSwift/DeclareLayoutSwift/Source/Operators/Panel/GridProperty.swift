//
//  GridProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/29.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum GridPropertyName {
    case rows, columns
}

public class GridProperty<TargetPropertyType>: PropertyBase<GridPropertyName> {
    public static var rows: GridProperty<[Grid.Definition]> {
        return GridProperty<[Grid.Definition]>(.rows)
    }
    public static var columns: GridProperty<[Grid.Definition]> {
        return GridProperty<[Grid.Definition]>(.columns)
    }
}

public func <- <TargetType, TargetPropertyType>(property: GridProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: Grid {
    let propertyName = property.propertyName
    switch propertyName {
    case .rows:
        return PropertySetter<TargetType>(setter: { $0.rows = value as? [Grid.Definition] })
    case .columns:
        return PropertySetter<TargetType>(setter: { $0.columns = value as? [Grid.Definition] })
    }
}
