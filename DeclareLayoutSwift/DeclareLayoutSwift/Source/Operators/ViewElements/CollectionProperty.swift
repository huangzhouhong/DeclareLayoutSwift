//
//  Collection.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/14.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum CollectionPropertyName {
    case delegate
    case dataSource
}

public class CollectionProperty<TargetPropertyType>: PropertyBase<CollectionPropertyName> {
    public static var delegate: CollectionProperty<UICollectionViewDelegate> {
        return CollectionProperty<UICollectionViewDelegate>(.delegate)
    }

    public static var dataSource: CollectionProperty<UICollectionViewDataSource> {
        return CollectionProperty<UICollectionViewDataSource>(.dataSource)
    }
}

public func <- <TargetType, TargetPropertyType, ViewType>(property: CollectionProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: ViewElement<ViewType>, ViewType: UICollectionView {
    let propertyName = property.propertyName
    switch propertyName {
    case .delegate:
        return PropertySetter<TargetType>(setter: { $0.view.delegate = value as? UICollectionViewDelegate })
    case .dataSource:
        return PropertySetter<TargetType>(setter: { $0.view.dataSource = value as? UICollectionViewDataSource })
    }
}

// public func <- <ViewType, TargetPropertyType>(property: CollectionProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<ViewElement<ViewType>> where ViewType: UICollectionView  {
//    let propertyName = property.propertyName
//    switch propertyName {
//    case .delegate:
//        return PropertySetter<ViewElement<ViewType>>(setter: { $0.view.delegate = value as? UICollectionViewDelegate })
//    case .dataSource:
//        return PropertySetter<ViewElement<ViewType>>(setter: { $0.view.dataSource = value as? UICollectionViewDataSource })
//    }
// }
