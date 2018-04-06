//
//  VC+HostElement.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/6.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

extension UIViewController {
    public func hostElement(_ element: UIElement) {
        if element.context == nil {
            element.context = self
        }

        view.hostElement(element)
    }

    public func hostElement(createElementBlock: () -> UIElement) {
        self.hostElement(createElementBlock())
    }
}
