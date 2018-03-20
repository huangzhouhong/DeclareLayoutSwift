//
//  UIElement.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/10.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

public enum HorizontalAlignment {
    case Center, Left, Right, Stretch
}

public enum VerticalAlignment {
    case Center, Top, Bottom, Stretch
}

public class UIElement: NSObject, Layoutable {
    public var desiredSize: CGSize = CGSize.zero
    public var horizontalAlignment: HorizontalAlignment?
    public var verticalAlignment: VerticalAlignment?
    public var width: CGFloat?
    public var height: CGFloat?
    
    public var margin: UIEdgeInsets?
    public var padding: UIEdgeInsets?
    
    public var children: [Layoutable] = []
    public weak var parent: Layoutable?
    public var visibility: Visibility = .Visible {
        didSet {
            onVisibilityChanged()
        }
    }
    public var measured: Bool = false
    
    private weak var _hostView: UIView?
    var hostView: UIView? {
        get {
//            return _hostView ?? (parent == nil ? nil : ((parent as? UIView) ?? parent!.hostView))
            return _hostView ?? ((parent as? UIView) ?? (parent as? UIElement)?.hostView)
        }
        set {
            _hostView = newValue
        }
    }
    
    /* self padding means this element will calculate padding itself,
     such as label and button*/
    var selfPadding: Bool = false
    
//    override init() {
//        super.init()
//    }
    public func setup() {
        for var child in children {
            child.parent = self
            child.setup()
        }
        measured = false
    }
    
    // handle margin,padding,explicit size
    public final func measure(_ availableSize: DLSize) {
        var availableSize = availableSize
        availableSize.removeInset(inset: margin)
        
        if !selfPadding {
            availableSize.removeInset(inset: padding)
        }
        
        if let explicitWidth = width, let explicitHeight = height {
            desiredSize = CGSize(width: explicitWidth, height: explicitHeight)
        } else {
            let availableWidth = width ?? availableSize.width
            let availableHeight = height ?? availableSize.height
            desiredSize = measureOverwrite(DLSize(width: availableWidth, height: availableHeight))
            desiredSize.width = width ?? desiredSize.width
            desiredSize.height = height ?? desiredSize.height
        }
        
        if !selfPadding {
            desiredSize.addInset(inset: padding)
        }
        
        desiredSize.addInset(inset: margin)
        measured = true
    }
    
    func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        assert(false)
        return CGSize.zero
    }
    
    public func arrange(_ finalRect: CGRect) {
        let rect = finalRect.innerRectWithInset(margin)
        let innerRect = rect.innerRectWithInset(padding)
        arrangeOverwrite(rect: rect, innerRect: innerRect)
    }
    
    func arrangeOverwrite(rect: CGRect, innerRect: CGRect) {
        assert(false)
    }
    
    func onVisibilityChanged() {
        for child in children {
            child.visibility = visibility
        }
    }
}

// extension UIView : Layoutable{
//    struct PropertyNames {
//        static var desiredSize = "desiredSize"
//        static var parent = "parent"
//        static var horizontalAlignment = "horizontalAlignment"
//        static var verticalAlignment="verticalAlignment"
//        static var width="width"
//        static var height="height"
//    }
//
//    var desiredSize: CGSize{
//        get{
//            let size = getValue(key: &PropertyNames.desiredSize) as? CGSize
//            return size ?? CGSize.zero
//        }
//        set{
//            setValue(key: &PropertyNames.desiredSize, value: newValue)
//        }
//    }
//
//    var horizontalAlignment:HorizontalAlignment?
//    {
//        get{
//            return getValue(key: &PropertyNames.horizontalAlignment) as? HorizontalAlignment
//        }
//        set{
//            setValue(key: &PropertyNames.horizontalAlignment, value: newValue)
//        }
//    }
//    var verticalAlignment:VerticalAlignment? {
//        get{
//            return getValue(key: &PropertyNames.verticalAlignment) as? VerticalAlignment
//        }
//        set{
//            setValue(key: &PropertyNames.verticalAlignment, value: newValue)
//        }
//    }
//    var width:CGFloat? {
//        get{
//            return getValue(key: &PropertyNames.width) as? CGFloat
//        }
//        set{
//            setValue(key: &PropertyNames.width, value: newValue)
//        }
//    }
//    var height:CGFloat? {
//        get{
//            return getValue(key: &PropertyNames.height) as? CGFloat
//        }
//        set{
//            setValue(key: &PropertyNames.height, value: newValue)
//        }
//    }
//
//    var parent: Layoutable? {
//        get {
//            return getValue(key: &PropertyNames.parent) as? Layoutable
//        }
//        set {
//            setValue(key: &PropertyNames.parent, value: newValue)
//        }
//    }
//
//    func setup() {
//
//    }
//
//    func measure(_ availableSize: CGSize) {
//        desiredSize = sizeThatFits(availableSize)
//        print("desiredSize for Label:\(desiredSize)")
//    }
//
//    func arrange(_ finalRect: CGRect) {
//        hostView?.addSubview(self)
//        frame=finalRect
//        print("arrange for Label:\(desiredSize)")
//    }
// }

// extension UILabel:Layoutable{
//
//    func measure(_ availableSize: CGSize) {
//        desiredSize = sizeThatFits(availableSize)
//        print("desiredSize for Label:\(desiredSize)")
//    }
//
//    func arrange(_ finalRect: CGRect) {
//        hostView?.addSubview(self)
//        frame=finalRect
//        print("arrange for Label:\(desiredSize)")
//    }
// }

// class DeclareLayoutView: UIView {
//    var hostElement: UIElement?
//    func loadUIElement(ele: UIElement) {
//        hostElement = ele
////        ele.parent=self
////        layoutElements()
//    }
//
////    override var bounds: CGRect{
////        didSet{
////            layoutElements()
////        }
////    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        SpeedLog.print("start layoutSubviews")
//        layoutElements()
//    }
//
//    func layoutElements() {
//        guard let hostElement = hostElement else {
//            return
//        }
//
//        hostElement.setup()
//        hostElement.measure(DLSize(self.bounds.size))
//        hostElement.arrange(self.bounds)
//    }
//
//    override func draw(_ rect: CGRect) {
//
//    }
// }
