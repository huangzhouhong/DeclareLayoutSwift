//
//  HostView.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/4.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public class HostView: UIView, Layoutable {
    
    public var desiredSize: CGSize = CGSize.zero
    
    public var horizontalAlignment: HorizontalAlignment?
    
    public var verticalAlignment: VerticalAlignment?
    
    public var width: CGFloat?
    
    public var height: CGFloat?
    
    public var margin: UIEdgeInsets?
    
    public var padding: UIEdgeInsets?
    
    public var children: [Layoutable] = []
    
    public var parent: Layoutable?
    
    public var visibility: Visibility = .Visible {
        didSet {
            isHidden = visibility != .Visible
        }
    }
    
    public var measured: Bool = false
    
    public func setup() {
        hostElement.parent = self
        hostElement.setup()
    }
    
    public func measure(_ availableSize: DLSize) {
        hostElement.measure(availableSize)
    }
    
    public func arrange(_ finalRect: CGRect) {
        frame = finalRect
    }
    
    var hostElement: UIElement
    public init(createElementBlock: () -> UIElement) {
        hostElement = createElementBlock()
        super.init(frame: CGRect.zero)
        hostElement.parent = self
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
//        guard let hostElement = hostElement else{
//            return
//        }
        
        hostElement.setup()
        hostElement.measure(DLSize(bounds.size))
        hostElement.arrange(bounds)
    }
}
//    var measured: Bool = false
//
//
//    var desiredSize: CGSize{
//        get{
//            return hostElement.desiredSize
//        }
//        set{
//            hostElement.desiredSize = newValue
//        }
//    }
//
//    var horizontalAlignment: HorizontalAlignment?{
//        get{
//            return hostElement.horizontalAlignment
//        }
//        set{
//            hostElement.horizontalAlignment = newValue
//        }
//    }
//
//    var verticalAlignment: VerticalAlignment?{
//        get{
//            return hostElement.verticalAlignment
//        }
//        set{
//            hostElement.verticalAlignment = newValue
//        }
//    }
//
//    var width: CGFloat?{
//        get{
//            return hostElement.width
//        }
//        set{
//            hostElement.width = newValue
//        }
//    }
//
//    var height: CGFloat?{
//        get{
//            return hostElement.height
//        }
//        set{
//            hostElement.height = newValue
//        }
//    }
//
//    var margin: UIEdgeInsets?{
//        get{
//            return hostElement.margin
//        }
//        set{
//            hostElement.margin = newValue
//        }
//    }
//
//    var padding: UIEdgeInsets?{
//        get{
//            return hostElement.padding
//        }
//        set{
//            hostElement.padding = newValue
//        }
//    }
//
//    var children: [Layoutable]{
//        get{
//            return hostElement.children
//        }
//        set{
//            hostElement.children = newValue
//        }
//    }
//
//    var parent: Layoutable?
//    {
//        get{
//            return hostElement.parent
//        }
//        set{
//            hostElement.parent = newValue
//        }
//    }
