//
//  PropertyBase.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/29.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

/*
 属性初始化设计目标
 1.属性可选，随意顺序（构造函数不满足随意顺序）
 2.强类型（属性赋值）
 3.有继承关系的，属性应当也有对应的继承关系。没有继承关系的，不能用来初始化
 e.g. Layoutable属性可以用在Grid上,在StackPanel属性不能用在Grid上
 */

public class PropertyBase<EnumType> {
    var propertyName: EnumType
    init(_ propertyName: EnumType) {
        self.propertyName = propertyName
    }
}

public class PropertySetter<TargetType> {
    var setter: (TargetType) -> Void
    init(setter: @escaping (TargetType) -> Void) {
        self.setter = setter
    }
}
