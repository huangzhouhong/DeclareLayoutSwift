//
//  PagesProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/16.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum PagesPropertyName {
    case pagesDelegate, scrollDuration, loop
}

public class PagesProperty<TargetPropertyType>: PropertyBase<PagesPropertyName> {
    // `delegate` operator exist in `CollectionView`
    public static var pagesDelegate: PagesProperty<PagesDelegate> {
        return PagesProperty<PagesDelegate>(.pagesDelegate)
    }
    public static var scrollDuration: PagesProperty<TimeInterval> {
        return PagesProperty<TimeInterval>(.scrollDuration)
    }
    public static var loop: PagesProperty<Bool> {
        return PagesProperty<Bool>(.loop)
    }
}

public func <- <TargetType, TargetPropertyType>(property: PagesProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: Pages {
    let propertyName = property.propertyName
    switch propertyName {
    case .pagesDelegate:
        return PropertySetter<TargetType>(setter: { $0.pagesDelegate = value as? PagesDelegate })
    case .scrollDuration:
        return PropertySetter<TargetType>(setter: { $0.scrollDuration = value as! TimeInterval })
    case .loop:
        return PropertySetter<TargetType>(setter: { $0.loop = value as! Bool })
    }
}
