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
    let view: ViewType
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
    }
    
    public convenience override init() {
        self.init(view: ViewType())
    }
    
    public convenience init(_ propertySetters: PropertySetter<ViewElement>...) {
        self.init()
        propertySetters.forEach { $0.setter(self) }
    }
    
    public convenience init(_ propertySetters: PropertySetter<ViewElement>..., createChild: () -> ViewType) {
        self.init(view: createChild())
        propertySetters.forEach { $0.setter(self) }
    }
    
    public override func measure(_ availableSize: DLSize) {
        if view is SelfPaddingable {
            var availableSize = availableSize
            availableSize.removeInset(inset: margin)
            desiredSize = measureOverwrite(availableSize)
            desiredSize.addInset(inset: margin)
            measured = true
        } else {
            return super.measure(availableSize)
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

public typealias Label = ViewElement<UILabel>
public typealias Button = ViewElement<UIButton>
public typealias TextField = ViewElement<UITextField>

// class Button: ViewElement<UIButton> {
//    convenience init(_ propertySetters: PropertySetter<Button>...) {
//        self.init()
//        propertySetters.forEach { $0.setter(self) }
//    }
// }
//
// class Label: ViewElement<UILabel> {
//    convenience init(_ propertySetters: PropertySetter<Label>...) {
//        self.init()
//        propertySetters.forEach { $0.setter(self) }
//    }
// }
