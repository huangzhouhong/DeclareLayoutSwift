//
//  Insets.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/2/9.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public typealias Insets = UIEdgeInsets

public extension Insets {
    init(_ space: CGFloat) {
        self.init(top: space, left: space, bottom: space, right: space)
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        self.init(top: top ?? 0, left: left ?? 0, bottom: bottom ?? 0, right: right ?? 0)
    }
}
