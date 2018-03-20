//
//  HostView.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/4.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public class HostView: UIView {
    var hostElement: UIElement
    public convenience init(createElementBlock: () -> UIElement) {
        self.init(element: createElementBlock())
    }
    
    public init(element: UIElement) {
        hostElement = element
        super.init(frame: CGRect.zero)
        hostElement.hostView = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        SpeedLog.print("start layoutSubviews")
        layoutElements()
    }
    
    func layoutElements() {
        hostElement.setup()
        hostElement.measure(DLSize(bounds.size))
        hostElement.arrange(bounds)
    }
}
