//
//  UIView+HostElment.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/6.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

extension UIView {
    public func hostElement(_ element: UIElement) {
        let hostView = HostView(element: element)
        self.addSubview(hostView)
        //        self.backgroundColor = .white

        let margin = self.safeAreaLayoutGuide
        hostView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        hostView.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        hostView.rightAnchor.constraint(equalTo: margin.rightAnchor).isActive = true
        hostView.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        hostView.translatesAutoresizingMaskIntoConstraints = false
    }

    public func hostElement(createElementBlock: () -> UIElement) {
        self.hostElement(createElementBlock())
    }
}
