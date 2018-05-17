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
    

    public weak var parent: Layoutable?
    public var visibility: Visibility = .Visible {
        didSet {
            onVisibilityChanged()
        }
    }
    public var measured: Bool = false
    
    private weak var _hostView: UIView?
    public var hostView: UIView? {
        get {
//            return _hostView ?? (parent == nil ? nil : ((parent as? UIView) ?? parent!.hostView))
            return _hostView ?? ((parent as? UIView) ?? (parent as? UIElement)?.hostView)
        }
        set {
            _hostView = newValue
        }
    }
    
    private weak var _context: AnyObject?
    public var context: AnyObject? {
        get {
            return _context ?? parent?.context
        }
        set {
            _context = newValue
        }
    }
    
    /* self padding means this element will calculate padding itself,
     such as label and button*/
    var selfPadding: Bool = false
    
//    override init() {
//        super.init()
//    }
    public func setup() {
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
    }
}
