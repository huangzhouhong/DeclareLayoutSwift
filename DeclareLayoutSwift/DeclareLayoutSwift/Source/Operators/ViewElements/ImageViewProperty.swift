//
//  ImageView.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/2/5.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum ImageViewPropertyName {
    case image
}

public class ImageViewProperty<TargetPropertyType>: PropertyBase<ImageViewPropertyName> {
    // `Any` since support multiple type
    public static var image: ImageViewProperty<Any?> {
        return ImageViewProperty<Any?>(.image)
    }
}

public func <- <TargetType, TargetPropertyType>(property: ImageViewProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: ImageView {
    let propertyName = property.propertyName
    switch propertyName {
    case .image:
        return PropertySetter<TargetType>(setter: {
            if let name = value as? String {
                $0.view.image = UIImage(named: name)
            } else {
                $0.view.image = value as? UIImage
            }
        })
    }
}
