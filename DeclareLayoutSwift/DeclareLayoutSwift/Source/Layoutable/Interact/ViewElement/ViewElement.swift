//
//  ViewElement.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/31.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

public protocol SelfPaddingable {
    var padding: UIEdgeInsets? { get set }
}

extension UIButton: SelfPaddingable {
    public var padding: UIEdgeInsets? {
        get {
            return contentEdgeInsets
        }
        set {
            contentEdgeInsets = newValue ?? UIEdgeInsets.zero
        }
    }
}

public class ViewElement<ViewType>: UIElement where ViewType: UIView {
    public let view: ViewType
    public override var padding: UIEdgeInsets? {
        get {
            if let selfPaddingable = view as? SelfPaddingable {
                return selfPaddingable.padding
            } else {
                return super.padding
            }
        }
        set {
            if var selfPaddingable = view as? SelfPaddingable {
                selfPaddingable.padding = newValue
            } else {
                super.padding = newValue
            }
        }
    }
    
    public init(view: ViewType) {
        self.view = view
        
        super.init()
        self.selfPadding = view is SelfPaddingable
    }
    
    public convenience init(_ propertySetters: PropertySetter<ViewElement>..., configViewBlock: ((ViewType) -> Void)? = nil) {
        self.init(view: ViewType())
        propertySetters.forEach { $0.setter(self) }
        configViewBlock?(self.view)
    }
    
    public convenience init(_ propertySetters: PropertySetter<ViewElement>..., createViewBlock: () -> ViewType) {
        self.init(view: createViewBlock())
        propertySetters.forEach { $0.setter(self) }
    }
    
    override func onVisibilityChanged() {
        self.view.isHidden = visibility != .Visible
        
    }
    
    public override func setup() {
        super.setup()
        
        if view is UIControl {
            (self as! SupportControlEvent).setupControlEvent()
        }
    }
    
    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        return self.view.sizeThatFits(CGSize(availableSize))
    }
    
    override func arrangeOverwrite(rect: CGRect, innerRect: CGRect) {
        hostView?.addSubview(self.view)
        
        if view is SelfPaddingable {
            self.view.frame = rect
        } else {
            self.view.frame = innerRect
        }
    }
    
}

public class PaddingTextField: UITextField, SelfPaddingable {
    public var padding: UIEdgeInsets?
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.innerRectWithInset(self.padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.innerRectWithInset(self.padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.innerRectWithInset(self.padding)
    }
    
}

public typealias View = ViewElement<UIView>
public typealias Label = ViewElement<UILabel>
public typealias Button = ViewElement<UIButton>
public typealias TextField = ViewElement<PaddingTextField>
public typealias PageControl = ViewElement<UIPageControl>
