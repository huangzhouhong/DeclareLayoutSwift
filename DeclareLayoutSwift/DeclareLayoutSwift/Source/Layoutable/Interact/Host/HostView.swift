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
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
//        return super.sizeThatFits(size)
        hostElement.setup()
        let availableWidth = size.width > 0 ? size.width : CGFloat.nan
        let availableHeight = size.height > 0 ? size.height : CGFloat.nan
        hostElement.measure(DLSize(width: availableWidth, height: availableHeight))
//        hostElement.measure(DLSize(width: size.width, height: CGFloat.nan))
//        hostElement.measure(DLSize(size))
        return hostElement.desiredSize
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        SpeedLog.print("start layoutSubviews")
        layoutElements()
    }
    
    func layoutElements() {
        hostElement.setup()
//        hostElement.measure(DLSize(bounds.size))
        hostElement.arrange(bounds)
    }
}
