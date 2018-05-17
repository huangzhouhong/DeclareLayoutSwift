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

extension UIScrollView: SelfPaddingable {
    public var padding: UIEdgeInsets? {
        get {
            return contentInset
        }
        set {
            contentInset = newValue ?? UIEdgeInsets.zero
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

    public init(view: ViewType, propertySetters: [PropertySetter<ViewElement>]? = nil) {
        self.view = view
        super.init()
        propertySetters?.forEach { $0.setter(self) }
        selfPadding = view is SelfPaddingable
    }

    public convenience init(_ propertySetters: PropertySetter<ViewElement>..., configViewBlock: ((ViewType) -> Void)? = nil) {
        self.init(view: ViewType(), propertySetters: propertySetters)
        configViewBlock?(view)
    }

    public convenience init(_ propertySetters: PropertySetter<ViewElement>..., createViewBlock: () -> ViewType) {
        self.init(view: createViewBlock(), propertySetters: propertySetters)
    }

    override func onVisibilityChanged() {
        view.isHidden = visibility != .Visible
    }
    
    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        return view.sizeThatFits(CGSize(availableSize))
    }

    override func arrangeOverwrite(rect: CGRect, innerRect: CGRect) {
        hostView?.addSubview(view)

        if view is SelfPaddingable {
            view.frame = rect
        } else {
            view.frame = innerRect
        }
    }
}

public class PaddingTextField: UITextField, SelfPaddingable {
    public var padding: UIEdgeInsets?
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.innerRectWithInset(padding)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.innerRectWithInset(padding)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.innerRectWithInset(padding)
    }
}

public typealias View = ViewElement<UIView>
public typealias Label = ViewElement<UILabel>
public typealias Button = ViewElement<UIButton>
public typealias TextField = ViewElement<PaddingTextField>
// public typealias PageControl = ViewElement<UIPageControl>

public class PageControl: ViewElement<UIPageControl> {
    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        // let measure return correct height
        if view.numberOfPages == 0 {
            view.numberOfPages = 1
        }
        return super.measureOverwrite(availableSize)
    }
}
