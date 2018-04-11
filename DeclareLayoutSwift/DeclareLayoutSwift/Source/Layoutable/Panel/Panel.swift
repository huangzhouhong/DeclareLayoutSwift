//
//  Panel.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/25.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public class Panel: UIElement {
    public var children: [Layoutable] = []

    public override func setup() {
        for child in children {
            child.parent = self
            child.setup()
        }
        super.setup()
    }

    override func onVisibilityChanged() {
        for child in children {
            child.visibility = visibility
        }
    }

    public subscript(children: Layoutable...) -> Panel {
        self.children = children
        return self
    }
}
