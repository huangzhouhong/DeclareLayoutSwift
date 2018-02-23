//
//  Panel.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/25.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public class Panel: UIElement {
    override init() {
        super.init()
    }

    init(createChildren: () -> [Layoutable]) {
        super.init()
        children = createChildren()
    }

//    convenience init(_ propertySetters: PropertySetterProtocol..., createChildren: () -> [Layoutable]) {
//        self.init(createChildren: createChildren)
//        propertySetters.setupForTarget(self)
//        //        for propertySetter in propertySetters {
//        //            propertySetter.setValueForTarget(self)
//        //        }
//    }
}
