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
    case dataSource
    case header
}

public class TableProperty<TargetPropertyType>: PropertyBase<TablePropertyName> {
    public static var delegate: TableProperty<UITableViewDelegate> {
        return TableProperty<UITableViewDelegate>(.delegate)
    }

    public static var dataSource: TableProperty<UITableViewDataSource> {
        return TableProperty<UITableViewDataSource>(.dataSource)
    }

    public static var header: TableProperty<UIElement?> {
        return TableProperty<UIElement?>(.header)
    }
}

public func <- <TargetType, TargetPropertyType, ViewType>(property: TableProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: ViewElement<ViewType>, ViewType: UITableView {
    let propertyName = property.propertyName
    switch propertyName {
    case .delegate:
        return PropertySetter<TargetType>(setter: { $0.view.delegate = value as? UITableViewDelegate })
    case .dataSource:
        return PropertySetter<TargetType>(setter: { $0.view.dataSource = value as? UITableViewDataSource })
    case .header:
        return PropertySetter<TargetType>(setter: {
            target in
            if let t = target as? Table{
                t.header = value as? UIElement
            }
        })
    }
}

// public func <- <ViewType, TargetPropertyType>(property: TableProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<ViewElement<ViewType>> where ViewType: UITableView{
//    let propertyName = property.propertyName
//    switch propertyName {
//    case .delegate:
//        return PropertySetter<ViewElement<ViewType>>(setter: { $0.view.delegate = value as? UITableViewDelegate })
//    case .dataSource:
//        return PropertySetter<ViewElement<ViewType>>(setter: { $0.view.dataSource = value as? UITableViewDataSource })
//    }
// }
