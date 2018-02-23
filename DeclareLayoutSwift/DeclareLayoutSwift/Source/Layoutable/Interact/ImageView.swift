//
//  ImageViewElement.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/26.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public class ImageView: ViewElement<UIImageView> {
    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        if let rawSize = self.view.image?.size {
            let width = availableSize.width
            if !width.isNaN {
                let height = width * rawSize.height / rawSize.width
                return CGSize(width: width, height: height)
            }
            
            let height = availableSize.height
            if !height.isNaN{
                let width = height * rawSize.width / rawSize.height
                return CGSize(width: width, height: height)
            }
        }
        return super.measureOverwrite(availableSize)
    }
    
    public convenience init(_ propertySetters: PropertySetter<ImageView>...) {
        self.init()
        
        propertySetters.forEach { $0.setter(self)}
    }
}
