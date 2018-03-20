//
//  ImageView.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/2/5.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import SDWebImage
import UIKit

public enum ImagePropertyName {
    case image
}

public class ImageProperty<TargetPropertyType>: PropertyBase<ImagePropertyName> {
    // `Any` since support multiple type
    public static var image: ImageProperty<Any?> {
        return ImageProperty<Any?>(.image)
    }
}

public func <- <TargetType, TargetPropertyType, ViewType>(property: ImageProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: ViewElement<ViewType>, ViewType: UIImageView {
    let propertyName = property.propertyName
    switch propertyName {
    case .image:
        return PropertySetter<TargetType>(setter: {
            if let string = value as? String {
                if string.hasPrefix("http") {
                    $0.view.sd_setImage(with: URL(string: string), completed: nil)
                } else {
                    $0.view.image = UIImage(named: string)
                }
            } else {
                $0.view.image = value as? UIImage
            }
        })
    }
}
